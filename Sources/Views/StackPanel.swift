import Foundation
import Observation
import WinUI

@propertyWrapper
class ReferenceType<T> {
    private var _storage: T

    init(wrappedValue: T) {
        _storage = wrappedValue
    }

    var wrappedValue: T {
        _read {
            yield _storage
        }
        _modify {
            yield &_storage
        }
        set {
            _storage = newValue
        }
    }
}

struct StackPanel<each Content: View>: UIViewRepresentable {
    var body: Never { fatalError() }
    var view: WinUI.StackPanel?
    let content: () -> (repeat each Content)
    let orientation: Orientation
    let verticalAlignment: VerticalAlignment
    let horizontalAlignment: HorizontalAlignment
    let spacing: Double
    @ReferenceType var eitherViewMap: [Int: Bool] = [:]
    @ReferenceType var emptyViewMap: [Int: Bool] = [:]
    @ReferenceType var renderedViews: [Int] = []

    init(
        orientation: Orientation = .vertical,
        verticalAlignment: VerticalAlignment = .center,
        horizontalAlignment: HorizontalAlignment = .center,
        spacing: Double = 20,
        @ViewBuilder content: @escaping () -> (repeat each Content)
    ) {
        self.content = content
        self.orientation = orientation
        self.horizontalAlignment = horizontalAlignment
        self.verticalAlignment = verticalAlignment
        self.spacing = spacing
    }

    mutating func makeUIView() -> WinUI.StackPanel? {
        view = WinUI.StackPanel()
        var i = 0
        for child in repeat each content() {
            if let eitherView = child as? any EitherViewProtocol {
                eitherViewMap[i] = eitherView.isFirst
            }
            if let view = child._makeView() {
                self.view?.children.append(view)
                renderedViews.append(i)
                emptyViewMap[i] = false
            } else {
                emptyViewMap[i] = true
            }
            i += 1
        }
        updateUIView()
        return view
    }

    func updateUIView() {
        if let view {
            withObservationTracking {
                var i = 0
                var viewsToRender: [Int] = []
                var viewsMap: [Int: UIElement] = [:]
                for child in repeat each content() {
                    if let eitherView = child as? any EitherViewProtocol {
                        if eitherViewMap[i] != eitherView.isFirst {
                            if let view = child._makeView() {
                                viewsToRender.append(i)
                                viewsMap[i] = view
                                emptyViewMap[i] = false
                            } else {
                                emptyViewMap[i] = true
                            }
                            eitherViewMap[i] = eitherView.isFirst
                        } else {
                            if !(emptyViewMap[i]!) {
                                viewsToRender.append(i)
                            }
                        }
                    } else {
                        viewsToRender.append(i)
                    }
                    i += 1
                }
                let operations = viewsToRender.difference(from: renderedViews)
                for operation in operations {
                    switch operation {
                    case let .insert(offset: offset, element: viewKey, _): 
                        self.view?.children.insertAt(UInt32(offset), viewsMap[viewKey])
                    case let .remove(offset: offset, _, _): 
                        self.view?.children.removeAt(UInt32(offset))
                    }
                }
                renderedViews = viewsToRender
                view.orientation = orientation
                view.verticalAlignment = verticalAlignment
                view.horizontalAlignment = horizontalAlignment
                view.spacing = spacing
            } onChange: {
                Task { @MainActor in
                    self.updateUIView()
                }
            }
        }
    }
}

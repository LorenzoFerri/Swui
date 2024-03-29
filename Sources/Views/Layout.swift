import WinUI

class LayoutState {
    var eitherViewMap: [Int: Bool] = [:]
    var emptyViewMap: [Int: Bool] = [:]
    var renderedViews: [Int] = []
}

@MainActor
protocol Layout: UIViewRepresentable where Self.UIViewType: WinUI.Panel {
    var state: LayoutState { get set }
    func makeLayout<each Content: View>(_ content: () -> (repeat each Content))
    func updateLayout<each Content: View>(_ content: () -> (repeat each Content))
}

extension Layout {
    func makeLayout<each Content: View>(_ content: () -> (repeat each Content)) {
        var i = 0
        for child in repeat each content() {
            if let eitherView = child as? any EitherViewProtocol {
                state.eitherViewMap[i] = eitherView.isFirst
            }
            if let view = child._makeView() {
                self.view?.children.append(view)
                state.renderedViews.append(i)
                state.emptyViewMap[i] = false
            } else {
                state.emptyViewMap[i] = true
            }
            i += 1
        }
    }

    func updateLayout<each Content: View>(_ content: () -> (repeat each Content)) {
        var i = 0
        var viewsToRender: [Int] = []
        var viewsMap: [Int: UIElement] = [:]
        var viewsToSet: [Int] = []
        for child in repeat each content() {
            if let eitherView = child as? any EitherViewProtocol {
                if state.eitherViewMap[i] != eitherView.isFirst {
                    if let view = child._makeView() {
                        if state.renderedViews.contains(i) {
                            viewsToSet.append(i)
                        }
                        viewsToRender.append(i)
                        viewsMap[i] = view
                        state.emptyViewMap[i] = false
                    } else {
                        state.emptyViewMap[i] = true
                    }
                    state.eitherViewMap[i] = eitherView.isFirst
                } else {
                    if !(state.emptyViewMap[i]!) {
                        viewsToRender.append(i)
                    }
                }
            } else {
                viewsToRender.append(i)
            }
            i += 1
        }
        let operations = viewsToRender.difference(from: state.renderedViews)
        for operation in operations {
            switch operation {
            case let .insert(offset: offset, element: viewKey, _):
                view?.children.insertAt(UInt32(offset), viewsMap[viewKey])
            case let .remove(offset: offset, _, _):
                view?.children.removeAt(UInt32(offset))
            }
        }
        for viewKey in viewsToSet {
            if let index = viewsToRender.firstIndex(of: viewKey) {
                view?.children.setAt(UInt32(index), viewsMap[viewKey])
            }
        }
        state.renderedViews = viewsToRender
    }
}
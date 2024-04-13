import Foundation
import Observation
import UWP
import WinUI

public struct StackPanel<Content: Group>: Panel {
    public var element: WinUI.StackPanel?
    var content: () -> Content
    @State private var orientation: Orientation = .vertical
    @State private var verticalAlignment: VerticalAlignment = .center
    @State private var horizontalAlignment: HorizontalAlignment = .center
    @State private var spacing: Double = 20.0
    internal var state = PanelState()

    public init(
        _ orientation: @escaping @autoclosure () -> Orientation = .vertical,
        @GroupBuilder content: @escaping () -> Content
    ) {
        self.content = content
        _ = self.orientation(orientation())
    }

    func append(_ element: WinUI.FrameworkElement) {
        self.element?.children.append(element)
    }

    func insertAt(_ position: Int, _ element: WinUI.FrameworkElement) {
        self.element?.children.insertAt(UInt32(position), element)
    }

    func removeAt(_ position: Int) {
        self.element?.children.removeAt(UInt32(position))
    }

    public mutating func makeUIElement() -> WinUI.StackPanel? {
        element = WinUI.StackPanel()
        makePanel(content)
        updateUIElement()
        return element
    }

    public func updateUIElement() {
        if let element {
            withObservationTracking {
                updatePanel(content)
                element.orientation = orientation
                element.verticalAlignment = verticalAlignment
                element.horizontalAlignment = horizontalAlignment
                element.spacing = spacing
            } onChange: {
                Task { @MainActor in
                    self.updateUIElement()
                }
            }
        }
    }
}

extension StackPanel {
    public func orientation(_ orientation: @escaping @autoclosure () -> Orientation) -> Self {
        withObservationTracking {
            self.orientation = orientation()
        } onChange: {
            Task { @MainActor in
                self.orientation(orientation())
            }
        }
        return self
    }


    public func horizontalAlignment(_ horizontalAlignment: @escaping @autoclosure () -> HorizontalAlignment) -> Self {
        withObservationTracking {
            self.horizontalAlignment = horizontalAlignment()
        } onChange: {
            Task { @MainActor in
                self.horizontalAlignment(horizontalAlignment())
            }
        }
        return self
    }


    public func verticalAlignment(_ verticalAlignment: @escaping @autoclosure () -> VerticalAlignment) -> Self {
        withObservationTracking {
            self.verticalAlignment = verticalAlignment()
        } onChange: {
            Task { @MainActor in
                self.verticalAlignment(verticalAlignment())
            }
        }
        return self
    }

    public func spacing(_ spacing: @escaping @autoclosure () -> Double) -> Self {
        withObservationTracking {
            self.spacing = spacing()
        } onChange: {
            Task { @MainActor in
                self.spacing(spacing())
            }
        }
        return self
    }
}

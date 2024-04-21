import Foundation
import Observation
import UWP
import WinUI

public struct StackPanel<Content: Group>: Panel {
    public var element: WinUI.StackPanel?
    var content: () -> Content
    @State private var orientation: Orientation = .vertical
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

    public mutating func makeUIElement(context: Context) -> WinUI.StackPanel? {
        element = WinUI.StackPanel()
        element?.horizontalAlignment = .center
        element?.verticalAlignment = .center
        makePanel(content, context: context)
        updateUIElement(context: context)
        return element
    }

    public func updateUIElement(context: Context) {
        if let element {
            withObservationTracking {
                updatePanel(content, context: context)
                element.orientation = orientation
                element.spacing = spacing
            } onChange: {
                Task { @MainActor in
                    self.updateUIElement(context: context)
                }
            }
        }
    }
}

public extension StackPanel {
    func orientation(_ orientation: @escaping @autoclosure () -> Orientation) -> Self {
        withObservationTracking {
            self.orientation = orientation()
        } onChange: {
            Task { @MainActor in
                self.orientation(orientation())
            }
        }
        return self
    }

    func spacing(_ spacing: @escaping @autoclosure () -> Double) -> Self {
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

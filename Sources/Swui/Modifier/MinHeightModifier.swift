import Observation
import WinUI
import SwuiMacros

public struct MinHeightModifier<Child: Element>: ElementModifier {
    public let child: Child
    public var element: FrameworkElement?

    @State private var minHeight: Double = .nan

    public init(
        @ElementBuilder child: @escaping () -> Child
    ) {
        self.child = child()
    }

    public func updateUIElement() {
        if let element {
            withObservationTracking {
                element.minHeight = minHeight
            } onChange: {
                Task { @MainActor in
                    self.updateUIElement()
                }
            }
        }
    }
}

public extension MinHeightModifier {
    func minHeight(
        _ minHeight: @escaping @autoclosure () -> Double
    ) -> Self {
        withObservationTracking {
            self.minHeight = minHeight()
        } onChange: {
            Task { @MainActor in
                self.minHeight(minHeight())
            }
        }
        return self
    }
}

public extension Element {
    func minHeight(
        _ minHeight: @escaping @autoclosure () -> Double
    ) -> MinHeightModifier<Self> {
        MinHeightModifier { self }.minHeight(minHeight())
    }
}
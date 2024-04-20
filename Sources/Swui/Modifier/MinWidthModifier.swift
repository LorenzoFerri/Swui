import Observation
import WinUI

public struct MinWidthModifier<Child: Element>: ElementModifier {
    public let child: Child
    public var element: FrameworkElement?

    @State private var minWidth: Double = .nan

    public init(
        @ElementBuilder child: @escaping () -> Child
    ) {
        self.child = child()
    }

    public func updateUIElement() {
        if let element {
            withObservationTracking {
                element.minWidth = minWidth
            } onChange: {
                Task { @MainActor in
                    self.updateUIElement()
                }
            }
        }
    }
}

public extension MinWidthModifier {
    func minWidth(
        _ minWidth: @escaping @autoclosure () -> Double
    ) -> Self {
        withObservationTracking {
            self.minWidth = minWidth()
        } onChange: {
            Task { @MainActor in
                self.minWidth(minWidth())
            }
        }
        return self
    }
}

public extension Element {
    func minWidth(
        _ minWidth: @escaping @autoclosure () -> Double
    ) -> MinWidthModifier<Self> {
        MinWidthModifier { self }.minWidth(minWidth())
    }
}
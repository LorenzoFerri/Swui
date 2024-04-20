import Observation
import WinUI

public struct MaxWidthModifier<Child: Element>: ElementModifier {
    public let child: Child
    public var element: FrameworkElement?

    @State private var maxWidth: Double = .nan

    public init(
        @ElementBuilder child: @escaping () -> Child
    ) {
        self.child = child()
    }
    public func updateUIElement() {
        if let element {
            withObservationTracking {
                element.maxWidth = maxWidth
            } onChange: {
                Task { @MainActor in
                    self.updateUIElement()
                }
            }
        }
    }
}

public extension MaxWidthModifier {
    func maxWidth(
        _ maxWidth: @escaping @autoclosure () -> Double
    ) -> Self {
        withObservationTracking {
            self.maxWidth = maxWidth()
        } onChange: {
            Task { @MainActor in
                self.maxWidth(maxWidth())
            }
        }
        return self
    }
}

public extension Element {
    func maxWidth(
        _ maxWidth: @escaping @autoclosure () -> Double
    ) -> MaxWidthModifier<Self> {
        MaxWidthModifier { self }.maxWidth(maxWidth())
    }
}
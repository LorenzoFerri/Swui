import Observation
import WinUI
import SwuiMacros

public struct OpacityModifier<Child: Element>: ElementModifier {
    public let child: Child
    public var element: FrameworkElement?

    @State private var opacity: Double = 1.0

    public init(
        @ElementBuilder child: @escaping () -> Child
    ) {
        self.child = child()
    }

    public func updateUIElement() {
        if let element {
            withObservationTracking {
                element.opacity = opacity
            } onChange: {
                Task { @MainActor in
                    self.updateUIElement()
                }
            }
        }
    }
}

public extension OpacityModifier {
    func opacity(
        _ opacity: @escaping @autoclosure () -> Double
    ) -> Self {
        withObservationTracking {
            self.opacity = opacity()
        } onChange: {
            Task { @MainActor in
                self.opacity(opacity())
            }
        }
        return self
    }
}

public extension Element {
    func opacity(
        _ opacity: @escaping @autoclosure () -> Double
    ) -> OpacityModifier<Self> {
        OpacityModifier { self }.opacity(opacity())
    }
}
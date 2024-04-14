import Observation
import WinUI
import SwuiMacros

public struct WidthModifier<Child: Element>: ElementModifier {
    public let child: Child
    public var element: FrameworkElement?

    @State private var width: Double = .nan

    public init(
        @ElementBuilder child: @escaping () -> Child
    ) {
        self.child = child()
    }

    public func updateUIElement() {
        if let element {
            withObservationTracking {
                element.width = width
            } onChange: {
                Task { @MainActor in
                    self.updateUIElement()
                }
            }
        }
    }
}

public extension WidthModifier {
    func width(
        _ width: @escaping @autoclosure () -> Double
    ) -> Self {
        withObservationTracking {
            self.width = width()
        } onChange: {
            Task { @MainActor in
                self.width(width())
            }
        }
        return self
    }
}

public extension Element {
    func width(
        _ width: @escaping @autoclosure () -> Double
    ) -> WidthModifier<Self> {
        WidthModifier { self }.width(width())
    }
}
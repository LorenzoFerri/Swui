import Observation
import WinUI

public struct MarginModifier<Child: Element>: ElementModifier {
    public let child: Child
    public var element: FrameworkElement?

    @State private var margin: Thickness = .init()

    public init(
        @ElementBuilder child: @escaping () -> Child
    ) {
        self.child = child()
    }

    public func updateUIElement(context: Context) {
        if let element {
            withObservationTracking {
                element.margin = margin
            } onChange: {
                Task { @MainActor in
                    self.updateUIElement(context: context)
                }
            }
        }
    }
}

public extension MarginModifier {
    func margin(
        _ margin: @escaping @autoclosure () -> Thickness
    ) -> Self {
        withObservationTracking {
            self.margin = margin()
        } onChange: {
            Task { @MainActor in
                self.margin(margin())
            }
        }
        return self
    }
}

public extension Element {
    func margin(
        _ margin: @escaping @autoclosure () -> Double
    ) -> MarginModifier<Self> {
        MarginModifier { self }.margin(
            .init(left: margin(), top: margin(), right: margin(), bottom: margin())
        )
    }

    func margin(
        left: @escaping @autoclosure () -> Double = 0.0,
        top: @escaping @autoclosure () -> Double = 0.0,
        right: @escaping @autoclosure () -> Double = 0.0,
        bottom: @escaping @autoclosure () -> Double = 0.0
    ) -> MarginModifier<Self> {
        MarginModifier { self }.margin(
            .init(left: left(), top: top(), right: right(), bottom: bottom())
        )
    }
}
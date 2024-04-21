import Observation
import WinUI

public struct MaxHeightModifier<Child: Element>: ElementModifier {
    public let child: Child
    public var element: FrameworkElement?

    @State private var maxHeight: Double = .nan

    public init(
        @ElementBuilder child: @escaping () -> Child
    ) {
        self.child = child()
    }

    public func updateUIElement(context: Context) {
        if let element {
            withObservationTracking {
                element.maxHeight = maxHeight
            } onChange: {
                Task { @MainActor in
                    self.updateUIElement(context: context)
                }
            }
        }
    }
}

public extension MaxHeightModifier {
    func maxHeight(
        _ maxHeight: @escaping @autoclosure () -> Double
    ) -> Self {
        withObservationTracking {
            self.maxHeight = maxHeight()
        } onChange: {
            Task { @MainActor in
                self.maxHeight(maxHeight())
            }
        }
        return self
    }
}

public extension Element {
    func maxHeight(
        _ maxHeight: @escaping @autoclosure () -> Double
    ) -> MaxHeightModifier<Self> {
        MaxHeightModifier { self }.maxHeight(maxHeight())
    }
}
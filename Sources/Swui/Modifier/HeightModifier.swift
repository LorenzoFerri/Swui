import Observation
import WinUI

public struct HeightModifier<Child: Element>: ElementModifier {
    public let child: Child
    public var element: FrameworkElement?

    @State private var height: Double = .nan

    public init(
        @ElementBuilder child: @escaping () -> Child
    ) {
        self.child = child()
    }

    public func updateUIElement() {
        if let element {
            withObservationTracking {
                element.height = height
            } onChange: {
                Task { @MainActor in
                    self.updateUIElement()
                }
            }
        }
    }
}

public extension HeightModifier {
    func height(
        _ height: @escaping @autoclosure () -> Double
    ) -> Self {
        withObservationTracking {
            self.height = height()
        } onChange: {
            Task { @MainActor in
                self.height(height())
            }
        }
        return self
    }
}

public extension Element {
    func height(
        _ height: @escaping @autoclosure () -> Double
    ) -> HeightModifier<Self> {
        HeightModifier { self }.height(height())
    }
}
import Observation
import WinUI

public struct VerticalAlignmentModifier<Child: Element>: ElementModifier {
    public let child: Child
    public var element: FrameworkElement?

    @State private var verticalAlignment: VerticalAlignment = .center

    public init(
        @ElementBuilder child: @escaping () -> Child
    ) {
        self.child = child()
    }

    public func updateUIElement(context: Context) {
        if let element {
            withObservationTracking {
                element.verticalAlignment = verticalAlignment
            } onChange: {
                Task { @MainActor in
                    self.updateUIElement(context: context)
                }
            }
        }
    }
}

public extension VerticalAlignmentModifier {
    func verticalAlignment(
        _ verticalAlignment: @escaping @autoclosure () -> VerticalAlignment
    ) -> Self {
        withObservationTracking {
            self.verticalAlignment = verticalAlignment()
        } onChange: {
            Task { @MainActor in
                self.verticalAlignment(verticalAlignment())
            }
        }
        return self
    }
}

public extension Element {
    func verticalAlignment(
        _ verticalAlignment: @escaping @autoclosure () -> VerticalAlignment
    ) -> VerticalAlignmentModifier<Self> {
        VerticalAlignmentModifier { self }.verticalAlignment(verticalAlignment())
    }
}
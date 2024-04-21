import Observation
import WinUI

public struct HorizontalAlignmentModifier<Child: Element>: ElementModifier {
    public let child: Child
    public var element: FrameworkElement?

    @State private var horizontalAlignment: HorizontalAlignment = .center

    public init(
        @ElementBuilder child: @escaping () -> Child
    ) {
        self.child = child()
    }

    public func updateUIElement(context: Context) {
        if let element {
            withObservationTracking {
                element.horizontalAlignment = horizontalAlignment
            } onChange: {
                Task { @MainActor in
                    self.updateUIElement(context: context)
                }
            }
        }
    }
}

public extension HorizontalAlignmentModifier {
    func horizontalAlignment(
        _ horizontalAlignment: @escaping @autoclosure () -> HorizontalAlignment
    ) -> Self {
        withObservationTracking {
            self.horizontalAlignment = horizontalAlignment()
        } onChange: {
            Task { @MainActor in
                self.horizontalAlignment(horizontalAlignment())
            }
        }
        return self
    }
}

public extension Element {
    func horizontalAlignment(
        _ horizontalAlignment: @escaping @autoclosure () -> HorizontalAlignment
    ) -> HorizontalAlignmentModifier<Self> {
        HorizontalAlignmentModifier { self }.horizontalAlignment(horizontalAlignment())
    }
}
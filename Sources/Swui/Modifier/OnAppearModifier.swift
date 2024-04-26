import Observation
import WinUI

public struct OnAppearModifier<Child: Element>: ElementModifier {
    public let child: Child
    public var element: FrameworkElement?

    private var task: () -> Void

    public init(
        @ElementBuilder child: @escaping () -> Child,
        task: @escaping () -> Void
    ) {
        self.child = child()
        self.task = task
    }

    public mutating func makeUIElement(context: Context) -> WinUI.FrameworkElement? {
        runTask()
        element = child.makeElement(context: context)
        updateUIElement(context: context)
        return element
    }

    public func updateUIElement(context _: Context) {}

    func runTask() {
        task()
    }
}

public extension Element {
    func onAppear(
        _ task: @escaping () -> Void
    ) -> OnAppearModifier<Self> {
        OnAppearModifier(child: { self }, task: task)
    }
}

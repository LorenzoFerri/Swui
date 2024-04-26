import Observation
import WinUI

public struct TaskModifier<Child: Element>: ElementModifier {
    public let child: Child
    public var element: FrameworkElement?

    private var task: () async -> Void

    public init(
        @ElementBuilder child: @escaping () -> Child,
        task: @escaping () async -> Void
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
        Task { @MainActor in
            await task()
        }
    }
}

public extension Element {
    func task(
        _ task: @escaping () async -> Void
    ) -> TaskModifier<Self> {
        TaskModifier(child: { self }, task: task)
    }
}

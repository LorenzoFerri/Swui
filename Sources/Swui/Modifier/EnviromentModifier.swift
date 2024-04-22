import Observation
import WinUI

public struct EnviromentModifier<Child: Element, T: Observable>: ElementModifier {
    public let child: Child
    public var element: FrameworkElement?
    var enviroment: T

    public init(
        enviroment: @autoclosure @escaping () -> T,
        @ElementBuilder child: @escaping () -> Child
    ) {
        self.child = child()
        self.enviroment = enviroment()
    }

    public mutating func makeUIElement(context: Context) -> WinUI.FrameworkElement? {
        var clonedEnviroments = context.enviroments
        clonedEnviroments[ObjectIdentifier(T.self)] = enviroment
        let clonedContext = Context(enviroments: clonedEnviroments)
        element = child.makeElement(context: clonedContext)
        return element
    }

    public func updateUIElement(context _: Context) {}
}


public extension Element {
    func enviroment<T: Observable>(
        _ enviroment: @escaping @autoclosure () -> T
    ) -> EnviromentModifier<Self, T> {
        EnviromentModifier(enviroment: enviroment()) {
            self
        }
    }
}

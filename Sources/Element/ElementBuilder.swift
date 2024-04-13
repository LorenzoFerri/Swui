@MainActor
@resultBuilder
public enum ElementBuilder {
    public static func buildBlock() -> EmptyElement {
        .init()
    }

    public static func buildBlock(_ content: Never) -> Never { }

    public static func buildBlock<Component: Element>(_ component: Component) -> Component {
        component
    }

    public static func buildOptional<Component: Element>(_ component: Component?) -> EitherElement<Component,EmptyElement> {
        if let component {
            EitherElement<Component,EmptyElement>(.first(component))
        } else {
            EitherElement<Component,EmptyElement>(.second(EmptyElement()))
        }
    }

    public static func buildEither<First: Element, Second: Element>(first component: First) -> EitherElement<First,Second> {
        EitherElement(.first(component))
    }

    public static func buildEither<First: Element, Second: Element>(second component: Second) -> EitherElement<First,Second> {
        EitherElement(.second(component))
    }
}


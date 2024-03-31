@MainActor
@resultBuilder
enum ElementBuilder {
    static func buildBlock() -> EmptyElement {
        .init()
    }

    static func buildBlock(_ content: Never) -> Never { }

    static func buildBlock<Component: Element>(_ component: Component) -> Component {
        component
    }

    static func buildOptional<Component: Element>(_ component: Component?) -> EitherElement<Component,EmptyElement> {
        if let component {
            EitherElement<Component,EmptyElement>(.first(component))
        } else {
            EitherElement<Component,EmptyElement>(.second(EmptyElement()))
        }
    }

    static func buildEither<First: Element, Second: Element>(first component: First) -> EitherElement<First,Second> {
        EitherElement(.first(component))
    }

    static func buildEither<First: Element, Second: Element>(second component: Second) -> EitherElement<First,Second> {
        EitherElement(.second(component))
    }
}


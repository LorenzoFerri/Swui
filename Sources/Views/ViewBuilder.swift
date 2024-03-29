@MainActor
@resultBuilder
enum ViewBuilder {
    static func buildBlock() -> EmptyView {
        .init()
    }

    static func buildBlock(_ content: Never) -> Never { }

    static func buildBlock<Component: View>(_ component: Component) -> Component {
        component
    }

    static func buildOptional<Component: View>(_ component: Component?) -> EitherView<Component,EmptyView> {
        if let component {
            EitherView<Component,EmptyView>(.first(component))
        } else {
            EitherView<Component,EmptyView>(.second(EmptyView()))
        }
    }

    static func buildEither<First: View, Second: View>(first component: First) -> EitherView<First,Second> {
        EitherView(.first(component))
    }

    static func buildEither<First: View, Second: View>(second component: Second) -> EitherView<First,Second> {
        EitherView(.second(component))
    }

    
    static func buildBlock<each V: View>(_ views: repeat each V) -> (repeat each V) {
        (repeat each views)
    }
}
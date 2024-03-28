@MainActor
@resultBuilder
enum ViewBuilder {
    static func buildBlock() -> EmptyView {
        .init()
    }

    static func buildBlock(_: Never) -> Never {}

    static func buildBlock<Component: View>(_ component: Component) -> Component {
        component
    }

    static func buildOptional<Component: View>(_ component: Component?) -> OptionalView<Component> {
        OptionalView(component)
    }

    static func buildBlock<each V: View>(_ views: repeat each V) -> (repeat each V) {
        (repeat each views)
    }
}

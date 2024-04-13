@MainActor
@resultBuilder
enum SceneBuilder {
    static func buildBlock<Component: Scene>(_ component: Component) -> Component {
        component
    }
}
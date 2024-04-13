@MainActor
@resultBuilder
public enum SceneBuilder {
    public static func buildBlock<Component: Scene>(_ component: Component) -> Component {
        component
    }
}
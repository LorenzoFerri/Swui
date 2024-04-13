import WinUI

@MainActor
public protocol App {
    associatedtype Content: Scene
    
    @SceneBuilder
    var content: Content { get }
    init()
}

extension App {
    public static func main() {
        WindowsApp.onLaunched = {
            let app = Self()
            app.content.run()
        }
        WindowsApp.main()
    }
}


class WindowsApp: SwiftApplication {
    static var onLaunched: (() -> Void)?
    override public func onLaunched(_: WinUI.LaunchActivatedEventArgs) {
        Task { @MainActor in
            Self.onLaunched?()
        }
    }
}
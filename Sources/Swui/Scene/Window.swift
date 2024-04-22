import WinUI

public struct Window<Content: Element>: Scene {
    var content: Content
    @State var window: WinUI.Window

    public init(@ElementBuilder _ content: @escaping () -> Content) {
        self.content = content()
        window = WinUI.Window()
        window.systemBackdrop = MicaBackdrop()
        try! window.appWindow.resize(.init(width: 1280, height: 720))
        let key = ObjectIdentifier(WinUI.Window.self)
        let context = Context(
            enviroments: [key: _window]
        )
        window.content = UIHostingController(rootElement: content(), context: context)
        window.extendsContentIntoTitleBar = true
    }

    public func run() {
        Task { @MainActor in
            try! window.activate()
        }
    }
}
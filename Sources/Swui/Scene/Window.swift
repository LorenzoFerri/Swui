import WinUI

public struct Window<Content: Element>: Scene {
    var content: Content
    @ReferenceType var window: WinUI.Window

    public init(@ElementBuilder _ content: @escaping () -> Content) {
        self.content = content()
        window = WinUI.Window()
        window.systemBackdrop = MicaBackdrop()
        window.content = UIHostingController(rootElement: content())
        window.extendsContentIntoTitleBar = true
    }

    public func run() {
        Task { @MainActor in
            try! window.activate()
        }
    }
}
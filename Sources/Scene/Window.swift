import WinUI

struct Window<Content: Element>: Scene {
    var content: Content
    @ReferenceType var window: WinUI.Window

    init(@ElementBuilder _ content: @escaping () -> Content) {
        self.content = content()
        window = WinUI.Window()
        window.systemBackdrop = MicaBackdrop()
        window.content = UIHostingController(rootElement: content())
        window.extendsContentIntoTitleBar = true
    }

    func run() {
        Task { @MainActor in
            try! window.activate()
        }
    }
}
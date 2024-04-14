import WinUI

public class UIHostingController<Content>: Frame
    where Content: Element
{
    @MainActor
    init(rootElement element: Content) {
        super.init()
        content = element.makeElement()
    }
}

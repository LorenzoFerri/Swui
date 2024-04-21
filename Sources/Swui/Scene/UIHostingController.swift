import WinUI

public class UIHostingController<Content>: Frame
    where Content: Element
{
    @MainActor
    init(rootElement element: Content, context: Context) {
        super.init()
        content = element.makeElement(context: context)
    }
}

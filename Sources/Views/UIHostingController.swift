import WinUI

class UIHostingController<Content>: Frame
    where Content: View
{
    @MainActor
    init(rootView view: Content) {
        super.init()
        content = view._makeView()
    }
}

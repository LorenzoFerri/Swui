import WinUI

protocol UIViewRepresentable: View
    where Self.Body == Never
{
    associatedtype UIViewType: UIElement
    @MainActor func makeUIView() -> Self.UIViewType?
    @MainActor func updateUIView(view: Self.UIViewType) -> Void
}
import WinUI
import Foundation
protocol UIViewRepresentable: View
    where Self.Body == Never
{
    associatedtype UIViewType: UIElement
    var view: UIViewType? { get set }
    @MainActor mutating func makeUIView() -> Self.UIViewType?
    @MainActor mutating func updateUIView() -> Void
}

extension UIViewRepresentable where Self.Body == Never {
    var body: Never {
        get { fatalError() }
    }
}
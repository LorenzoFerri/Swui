import WinUI
import Foundation
protocol UIElementRepresentable: Element
    where Self.Content == Never
{
    associatedtype UIElementType: FrameworkElement
    var element: UIElementType? { get set }
    @MainActor mutating func makeUIElement() -> Self.UIElementType?
    @MainActor func updateUIElement() -> Void
}

extension UIElementRepresentable where Self.Content == Never {
    var content: Never {
        get { fatalError() }
    }
}
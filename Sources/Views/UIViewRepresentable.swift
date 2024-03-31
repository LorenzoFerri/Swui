import WinUI
import Foundation
protocol UIElementRepresentable: Element
    where Self.Content == Never
{
    associatedtype UIElementType: UIElement
    var element: UIElementType? { get set }
    @MainActor mutating func makeUIElement() -> Self.UIElementType?
    @MainActor mutating func updateUIElement() -> Void
}

extension UIElementRepresentable where Self.Content == Never {
    var content: Never {
        get { fatalError() }
    }
}
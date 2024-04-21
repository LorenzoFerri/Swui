import WinUI
import Foundation
public protocol UIElementRepresentable: Element
    where Self.Content == Never
{
    associatedtype UIElementType: FrameworkElement
    var element: UIElementType? { get set }
    @MainActor mutating func makeUIElement(context: Context) -> Self.UIElementType?
    @MainActor func updateUIElement(context: Context) -> Void
}

extension UIElementRepresentable where Self.Content == Never {
    public var content: Never {
        get { fatalError() }
    }
}
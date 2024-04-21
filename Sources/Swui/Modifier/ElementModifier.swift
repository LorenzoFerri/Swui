import WinUI

@MainActor
public protocol ElementModifier: UIElementRepresentable {
    associatedtype Child: Element
    var child: Child { get }
}

public extension ElementModifier where Self.UIElementType == FrameworkElement{
    mutating func makeUIElement(context: Context) -> WinUI.FrameworkElement? {
        element = child.makeElement(context: context)
        updateUIElement(context: context)
        return element
    }
}
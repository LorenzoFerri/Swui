import WinUI

@MainActor
public protocol ElementModifier: UIElementRepresentable {
    associatedtype Child: Element
    var child: Child { get }
}

public extension ElementModifier where Self.UIElementType == FrameworkElement{
    mutating func makeUIElement() -> WinUI.FrameworkElement? {
        element = child.makeElement()
        updateUIElement()
        return element
    }
}
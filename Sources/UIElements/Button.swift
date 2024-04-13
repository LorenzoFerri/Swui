import Foundation
import WinUI
public struct Button: UIElementRepresentable {
    public var element: WinUI.Button?
    let text: String
    let onClick: (() -> Void)?

    public init(_ text: String, onClick: (() -> Void)? = nil) {
        self.text = text
        self.onClick = onClick
    }

    public mutating func makeUIElement() -> WinUI.Button? {
        element = WinUI.Button()
        if let element {
            let textBlock = WinUI.TextBlock()
            element.content = textBlock
            textBlock.text = text

            if let onClick = onClick {
                element.click.addHandler { _, _ in
                    onClick()
                }
            }
        }
        return element
    }

    public func updateUIElement() {}
}

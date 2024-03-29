import Foundation
import WinUI
struct Button: UIViewRepresentable {
    var view: WinUI.Button?
    let text: String
    let onClick: (() -> Void)?

    init(_ text: String, onClick: (() -> Void)? = nil) {
        self.text = text
        self.onClick = onClick
    }

    mutating func makeUIView() -> WinUI.Button? {
        view = WinUI.Button()
        if let view {
            let textBlock = WinUI.TextBlock()
            view.content = textBlock
            textBlock.text = text

            if let onClick = onClick {
                view.click.addHandler { _, _ in
                    onClick()
                }
            }
            return view
        } else {
            return nil
        }
    }

    func updateUIView() {}
}

import WinUI

struct Button: UIViewRepresentable {
    var body: Never { fatalError() }
    let text: String
    let onClick: (() -> Void)?

    init(_ text: String, onClick: (() -> Void)? = nil) {
        self.text = text
        self.onClick = onClick
    }

    func makeUIView() -> WinUI.Button? {
        let button = WinUI.Button()
        let textBlock = WinUI.TextBlock()
        button.content = textBlock
        textBlock.text = text

        if let onClick = onClick {
            button.click.addHandler { _, _ in
                onClick()
            }
        }
        return button
    }

    func updateUIView(view _: WinUI.Button) {}
}

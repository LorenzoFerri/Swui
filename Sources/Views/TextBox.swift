import Foundation
import Observation
import WinUI

struct TextBox: UIViewRepresentable {
    var body: Never { fatalError() }
    @Binding var value: String

    init(_ value: Binding<String>) {
        _value = value
    }

    func makeUIView() -> WinUI.TextBox? {
        let textBox = WinUI.TextBox()
        textBox.textChanged.addHandler { _, _ in
            value = textBox.text
        }
        updateUIView(view: textBox)
        return textBox
    }

    func updateUIView(view textBox: WinUI.TextBox) {
        withObservationTracking {
            textBox.text = value.description
        } onChange: {
            Task { @MainActor in
                self.updateUIView(view: textBox)
            }
        }
    }
}

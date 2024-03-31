import Foundation
import Observation
import WinUI

struct TextBox: UIElementRepresentable {
    var element: WinUI.TextBox?
    @Binding var value: String

    init(_ value: Binding<String>) {
        _value = value
    }

    mutating func makeUIElement() -> WinUI.TextBox? {
        element = WinUI.TextBox()
        if let element {
            element.textChanged.addHandler { [self] _, _ in
                self.value = element.text
            }
        }
        updateUIElement()
        return element
    }

    func updateUIElement() {
        if let element {
            withObservationTracking {
                element.text = value.description
            } onChange: {
                Task { @MainActor in
                    self.updateUIElement()
                }
            }
        }
    }
}

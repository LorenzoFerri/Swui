import Foundation
import Observation
import WinUI

public struct TextBox: UIElementRepresentable {
    public var element: WinUI.TextBox?
    @Binding var value: String

    public init(_ value: Binding<String>) {
        _value = value
    }

    public mutating func makeUIElement() -> WinUI.TextBox? {
        element = WinUI.TextBox()
        if let element {
            element.textChanged.addHandler { [self] _, _ in
                self.value = element.text
            }
        }
        updateUIElement()
        return element
    }

    public func updateUIElement() {
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

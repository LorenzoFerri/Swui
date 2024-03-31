import Foundation
import Observation
import WinUI

struct ToggleSwitch: UIElementRepresentable {
    var element: WinUI.ToggleSwitch?
    @Binding var value: Bool

    init(_ value: Binding<Bool>) {
        _value = value
    }

    mutating func makeUIElement() -> WinUI.ToggleSwitch? {
        element = WinUI.ToggleSwitch()
        if let element {
            element.toggled.addHandler { [self] _, _ in
                self.value = element.isOn
            }
        }
        updateUIElement()
        return element
    }

    func updateUIElement() {
        if let element {
            withObservationTracking {
                element.isOn = value
            } onChange: {
                Task { @MainActor in
                    self.updateUIElement()
                }
            }
        }
    }
}

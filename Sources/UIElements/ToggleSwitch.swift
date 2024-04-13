import Foundation
import Observation
import WinUI

public struct ToggleSwitch: UIElementRepresentable {
    public var element: WinUI.ToggleSwitch?
    @Binding var value: Bool

    public init(_ value: Binding<Bool>) {
        _value = value
    }

    public mutating func makeUIElement() -> WinUI.ToggleSwitch? {
        element = WinUI.ToggleSwitch()
        if let element {
            element.toggled.addHandler { [self] _, _ in
                self.value = element.isOn
            }
        }
        updateUIElement()
        return element
    }

    public func updateUIElement() {
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

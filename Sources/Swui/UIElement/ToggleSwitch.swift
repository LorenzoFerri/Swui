import Foundation
import Observation
import WinUI

public struct ToggleSwitch: UIElementRepresentable {
    public var element: WinUI.ToggleSwitch?
    @Binding var value: Bool

    public init(_ value: Binding<Bool>) {
        _value = value
    }

    public mutating func makeUIElement(context: Context) -> WinUI.ToggleSwitch? {
        element = WinUI.ToggleSwitch()
        if let element {
            element.toggled.addHandler { [self] _, _ in
                self.value = element.isOn
            }
        }
        updateUIElement(context: context)
        return element
    }

    public func updateUIElement(context: Context) {
        if let element {
            withObservationTracking {
                element.isOn = value
            } onChange: {
                Task { @MainActor in
                    self.updateUIElement(context: context)
                }
            }
        }
    }
}

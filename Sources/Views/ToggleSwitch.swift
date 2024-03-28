import Foundation
import Observation
import WinUI

struct ToggleSwitch: UIViewRepresentable {
    var body: Never { fatalError() }
    @Binding var value: Bool

    init(_ value: Binding<Bool>) {
        _value = value
    }

    func makeUIView() -> WinUI.ToggleSwitch? {
        let toggleSwitch = WinUI.ToggleSwitch()
        toggleSwitch.toggled.addHandler { _, _ in
            value = toggleSwitch.isOn
        }
        updateUIView(view: toggleSwitch)
        return toggleSwitch
    }

    func updateUIView(view toggleSwitch: WinUI.ToggleSwitch) {
        withObservationTracking {
            toggleSwitch.isOn = value
        } onChange: {
            Task { @MainActor in
                self.updateUIView(view: toggleSwitch)
            }
        }
    }
}

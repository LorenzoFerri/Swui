import Foundation
import Observation
import WinUI

struct ToggleSwitch: UIViewRepresentable {
    var body: Never { fatalError() }
    var view: WinUI.ToggleSwitch?
    @Binding var value: Bool

    init(_ value: Binding<Bool>) {
        _value = value
    }

    mutating func makeUIView() -> WinUI.ToggleSwitch? {
        view = WinUI.ToggleSwitch()
        if let view {
            view.toggled.addHandler { [self] _, _ in
                self.value = view.isOn
            }
        }
        updateUIView()
        return view
    }

    func updateUIView() {
        if let view {
            withObservationTracking {
                view.isOn = value
            } onChange: {
                Task { @MainActor in
                    self.updateUIView()
                }
            }
        }
    }
}

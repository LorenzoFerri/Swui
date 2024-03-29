import Foundation
import Observation
import WinUI

struct TextBox: UIViewRepresentable {
    var view: WinUI.TextBox?
    @Binding var value: String

    init(_ value: Binding<String>) {
        _value = value
    }

    mutating func makeUIView() -> WinUI.TextBox? {
        view = WinUI.TextBox()
        if let view {
            view.textChanged.addHandler { [self] _, _ in
                self.value = view.text
            }
        }
        updateUIView()
        return view
    }

    func updateUIView() {
        if let view {
            withObservationTracking {
                view.text = value.description
            } onChange: {
                Task { @MainActor in
                    self.updateUIView()
                }
            }
        }
    }
}

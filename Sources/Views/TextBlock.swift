import Dispatch
import Foundation
import Observation
import WinAppSDK
import WinUI

struct TextBlock<Value: LosslessStringConvertible>: UIViewRepresentable {
    var view: WinUI.TextBlock?
    var value: () -> Value
    let verticalAlignment: VerticalAlignment = .center
    let horizontalAlignment: HorizontalAlignment = .center

    init(_ value: @autoclosure @escaping () -> Value) {
        self.value = value
    }

    mutating func makeUIView() -> WinUI.TextBlock? {
        view = WinUI.TextBlock()
        updateUIView()
        return view
    }

    func updateUIView() {
        if let view {
            withObservationTracking {
                view.text = value().description
                view.verticalAlignment = verticalAlignment
                view.horizontalAlignment = horizontalAlignment
            } onChange: {
                Task { @MainActor in
                    self.updateUIView()
                }
            }
        }
    }
}

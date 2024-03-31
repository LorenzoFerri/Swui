import Dispatch
import Foundation
import Observation
import WinAppSDK
import WinUI

struct TextBlock<Value: LosslessStringConvertible>: UIElementRepresentable {
    var element: WinUI.TextBlock?
    var value: () -> Value
    let verticalAlignment: VerticalAlignment = .center
    let horizontalAlignment: HorizontalAlignment = .center

    init(_ value: @autoclosure @escaping () -> Value) {
        self.value = value
    }

    mutating func makeUIElement() -> WinUI.TextBlock? {
        element = WinUI.TextBlock()
        updateUIElement()
        return element
    }

    func updateUIElement() {
        if let element {
            withObservationTracking {
                element.text = value().description
                element.verticalAlignment = verticalAlignment
                element.horizontalAlignment = horizontalAlignment
            } onChange: {
                Task { @MainActor in
                    self.updateUIElement()
                }
            }
        }
    }
}

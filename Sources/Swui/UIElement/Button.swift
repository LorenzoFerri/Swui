import Foundation
import WinUI
import Observation

public struct Button<Value: LosslessStringConvertible>: UIElementRepresentable {
    public var element: WinUI.Button?
    let value: () -> Value
    let onClick: (() -> Void)?

    public init(_ value: @autoclosure @escaping () -> Value, onClick: (() -> Void)? = nil) {
        self.value = value
        self.onClick = onClick
    }

    public mutating func makeUIElement(context: Context) -> WinUI.Button? {
        element = WinUI.Button()
        if let element {
            // let textBlock = WinUI.TextBlock()
            if let onClick = onClick {
                element.click.addHandler { _, _ in
                    onClick()
                }
            }
        }
        updateUIElement(context: context)
        return element
    }

    public func updateUIElement(context: Context) {
        if let element {
            withObservationTracking {
                element.content = value().description
            } onChange: {
                Task { @MainActor in
                    self.updateUIElement(context: context)
                }
            }
        }
    }
}

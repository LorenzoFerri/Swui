import Dispatch
import Foundation
import Observation
import UWP
import WinAppSDK
import WinUI

public struct TextBlock<Value: LosslessStringConvertible>: UIElementRepresentable {
    public var element: WinUI.TextBlock?
    var value: () -> Value
    @State private var foregroundColor: Color?
    @State private var textAlignment: TextAlignment = .center

    public init(_ value: @autoclosure @escaping () -> Value) {
        self.value = value
    }

    public mutating func makeUIElement() -> WinUI.TextBlock? {
        element = WinUI.TextBlock()
        element?.horizontalAlignment = .center
        element?.verticalAlignment = .center
        updateUIElement()
        return element
    }

    public func updateUIElement() {
        if let element {
            withObservationTracking {
                element.text = value().description
                if let foregroundColor {
                    element.foreground = SolidColorBrush(foregroundColor)
                    element.textAlignment = textAlignment
                }
            } onChange: {
                Task { @MainActor in
                    self.updateUIElement()
                }
            }
        }
    }
}

public extension TextBlock {
    func foregroundColor(
        _ foregroundColor: @escaping @autoclosure () -> Color
    ) -> Self {
        withObservationTracking {
            self.foregroundColor = foregroundColor()
        } onChange: {
            Task { @MainActor in
                self.foregroundColor(foregroundColor())
            }
        }
        return self
    }

    func textAlignment(
        _ textAlignment: @escaping @autoclosure () -> TextAlignment
    ) -> Self {
        withObservationTracking {
            self.textAlignment = textAlignment()
        } onChange: {
            Task { @MainActor in
                self.textAlignment(textAlignment())
            }
        }
        return self
    }
}

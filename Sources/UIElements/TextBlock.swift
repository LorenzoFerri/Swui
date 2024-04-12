import Dispatch
import Foundation
import Observation
import UWP
import WinAppSDK
import WinUI

struct TextBlock<Value: LosslessStringConvertible>: UIElementRepresentable {
    var element: WinUI.TextBlock?
    var value: () -> Value
    @State private var verticalAlignment: VerticalAlignment = .center
    @State private var horizontalAlignment: HorizontalAlignment = .center
    @State private var foregroundColor: Color?

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
                if let foregroundColor {
                    element.foreground = SolidColorBrush(foregroundColor)
                }
            } onChange: {
                Task { @MainActor in
                    self.updateUIElement()
                }
            }
        }
    }
}

extension TextBlock {
    func horizontalAlignment(_ horizontalAlignment: @escaping @autoclosure () -> HorizontalAlignment) -> Self {
        return _horizontalAlignment(horizontalAlignment)
    }

    private func _horizontalAlignment(_ horizontalAlignment: @escaping () -> HorizontalAlignment) -> Self {
        withObservationTracking {
            self.horizontalAlignment = horizontalAlignment()
        } onChange: {
            Task { @MainActor in
                self._horizontalAlignment(horizontalAlignment)
            }
        }
        return self
    }

    func verticalAlignment(_ verticalAlignment: @escaping @autoclosure () -> VerticalAlignment) -> Self {
        return _verticalAlignment(verticalAlignment)
    }

    private func _verticalAlignment(_ verticalAlignment: @escaping () -> VerticalAlignment) -> Self {
        withObservationTracking {
            self.verticalAlignment = verticalAlignment()
        } onChange: {
            Task { @MainActor in
                self._verticalAlignment(verticalAlignment)
            }
        }
        return self
    }

    func foregroundColor(_ foregroundColor: @escaping @autoclosure () -> Color) -> Self {
        return _foregroundColor(foregroundColor)
    }

    private func _foregroundColor(_ foregroundColor: @escaping () -> Color) -> Self {
        withObservationTracking {
            self.foregroundColor = foregroundColor()
        } onChange: {
            Task { @MainActor in
                self._foregroundColor(foregroundColor)
            }
        }
        return self
    }
}

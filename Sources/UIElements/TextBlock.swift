import Dispatch
import Foundation
import Observation
import UWP
import WinAppSDK
import WinUI

public struct TextBlock<Value: LosslessStringConvertible>: UIElementRepresentable {
    public var element: WinUI.TextBlock?
    var value: () -> Value
    @State private var verticalAlignment: VerticalAlignment = .center
    @State private var horizontalAlignment: HorizontalAlignment = .center
    @State private var foregroundColor: Color?

    public init(_ value: @autoclosure @escaping () -> Value) {
        self.value = value
    }

    public mutating func makeUIElement() -> WinUI.TextBlock? {
        element = WinUI.TextBlock()
        updateUIElement()
        return element
    }

    public func updateUIElement() {
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
    public func horizontalAlignment(_ horizontalAlignment: @escaping @autoclosure () -> HorizontalAlignment) -> Self {
        withObservationTracking {
            self.horizontalAlignment = horizontalAlignment()
        } onChange: {
            Task { @MainActor in
                self.horizontalAlignment(horizontalAlignment())
            }
        }
        return self
    }


    public func verticalAlignment(_ verticalAlignment: @escaping @autoclosure () -> VerticalAlignment) -> Self {
        withObservationTracking {
            self.verticalAlignment = verticalAlignment()
        } onChange: {
            Task { @MainActor in
                self.verticalAlignment(verticalAlignment())
            }
        }
        return self
    }


    public func foregroundColor(_ foregroundColor: @escaping @autoclosure () -> Color) -> Self {
        withObservationTracking {
            self.foregroundColor = foregroundColor()
        } onChange: {
            Task { @MainActor in
                self.foregroundColor(foregroundColor())
            }
        }
        return self
    }
}

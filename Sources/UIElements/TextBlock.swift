import Dispatch
import Foundation
import Observation
import UWP
import WinAppSDK
import WinUI

struct TextBlock<Value: LosslessStringConvertible>: UIElementRepresentable {
    var element: WinUI.TextBlock?
    var value: () -> Value
    var verticalAlignment: VerticalAlignment = .center
    var horizontalAlignment: HorizontalAlignment = .center
    var color: Color?

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
                if let color {
                    element.foreground = SolidColorBrush(color)
                }
            } onChange: {
                Task { @MainActor in
                    self.updateUIElement()
                }
            }
        }
    }
}

protocol ElementStyler: Element {
    var style: Style { get set }
}

struct StyledElement<Content: Element>: ElementStyler {
    var content: Content
    var style: Style
}

extension TextBlock {
    mutating func verticalAlignment(_ alignment: VerticalAlignment) -> Self {
        verticalAlignment = alignment
        return self
    }

    mutating func horizontalAlignment(_ alignment: HorizontalAlignment) -> Self {
        horizontalAlignment = alignment
        return self
    }

    func color(_: Color) -> StyledElement<Self> {
        let style = Style()
        style.targetType = TypeName(name: "TextBlock", kind: .primitive)
        style.setters.append(Setter(WinUI.TextBlock.foregroundProperty, "red"))
        return StyledElement(content: self, style: style)
    }
}

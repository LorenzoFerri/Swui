import Foundation
import Observation
import WinUI
import UWP

struct StackPanel<Content: Group>: Panel {
    var element: WinUI.StackPanel?
    var content: () -> Content
    let orientation: Orientation
    let verticalAlignment: VerticalAlignment
    let horizontalAlignment: HorizontalAlignment
    let spacing: Double
    var state = PanelState()

    init(
        orientation: Orientation = .vertical,
        verticalAlignment: VerticalAlignment = .center,
        horizontalAlignment: HorizontalAlignment = .center,
        spacing: Double = 20,
        @GroupBuilder content: @escaping () -> Content
    ) {
        self.content = content
        self.orientation = orientation
        self.horizontalAlignment = horizontalAlignment
        self.verticalAlignment = verticalAlignment
        self.spacing = spacing
    }

    mutating func makeUIElement() -> WinUI.StackPanel? {
        element = WinUI.StackPanel()
        makePanel(content)
        updateUIElement()
        return element
    }

    func updateUIElement() {
        if let element {
            withObservationTracking {
                updatePanel(content)
                element.orientation = orientation
                element.verticalAlignment = verticalAlignment
                element.horizontalAlignment = horizontalAlignment
                element.spacing = spacing
            } onChange: {
                Task { @MainActor in
                    self.updateUIElement()
                }
            }
        }
    }
}

extension StackPanel {
    func color(_ color: Color) -> StyledElement<Self> {
        let style = Style()
        style.targetType = TypeName(name: "TextBlock", kind: .primitive)
        style.setters.append(Setter(WinUI.TextBlock.foregroundProperty, color))
        return StyledElement(content: self, style: style)
    }
}

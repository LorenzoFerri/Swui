import Foundation
import Observation
import WinUI

struct StackPanel<each Content: Element>: Panel {
    var element: WinUI.StackPanel?
    var content: () -> (repeat each Content)
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
        @ElementBuilder content: @escaping () -> (repeat each Content)
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

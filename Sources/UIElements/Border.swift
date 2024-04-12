import Observation
import UWP
import WinUI

struct Border<Content: Element>: UIElementRepresentable {
    var element: WinUI.Border?
    var content: () -> Content
    var borderThickness: () -> Thickness
    var backgroundColor: () -> Color

    init(
        borderThickness: @autoclosure @escaping () -> Thickness = .init(),
        backgroundColor: @autoclosure @escaping () -> Color = .transparent,
        @ElementBuilder _ content: @escaping () -> Content
    ) {
        self.content = content
        self.borderThickness = borderThickness
        self.backgroundColor = backgroundColor
    }

    mutating func makeUIElement() -> WinUI.Border? {
        element = WinUI.Border()
        updateUIElement()
        return element
    }

    func updateUIElement() {
        if let element {
            withObservationTracking {
                element.child = content().makeElement()
                element.borderThickness = borderThickness()
                element.background = SolidColorBrush(backgroundColor())
            } onChange: {
                Task { @MainActor in
                    self.updateUIElement()
                }
            }
        }
    }
}

extension Element {
    func border(_ all: @autoclosure @escaping () -> Double = 16.0) -> Border<Self> {
        return Border(borderThickness: .init(
            left: all(),
            top: all(),
            right: all(),
            bottom: all()
        )) { self }
    }

    func border(
        left: @autoclosure @escaping () -> Double = 0.0,
        top: @autoclosure @escaping () -> Double = 0.0,
        right: @autoclosure @escaping () -> Double = 0.0,
        bottom: @autoclosure @escaping () -> Double = 0.0
    ) -> Border<Self> {
        return Border(borderThickness: .init(
            left: left(),
            top: top(),
            right: right(),
            bottom: bottom()
        )) { self }
    }

    func border(
        horizontal: @autoclosure @escaping () -> Double = 0.0,
        vertical: @autoclosure @escaping () -> Double = 0.0
    ) -> Border<Self> {
        return Border(borderThickness: .init(
            left: horizontal(),
            top: vertical(),
            right: horizontal(),
            bottom: vertical()
        )) { self }
    }

    func background(_ backgroundColor: @autoclosure @escaping () -> Color) -> Border<Self> {
        return Border(backgroundColor: backgroundColor()) { self }
    }
}

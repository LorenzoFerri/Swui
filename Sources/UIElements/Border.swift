import Observation
import WinUI

struct Border<Content: Element>: UIElementRepresentable {
    var element: WinUI.Border?
    var content: () -> Content
    @State var borderThickness: Thickness = .init(left: 16.0, top: 16.0, right: 16.0, bottom: 16.0)

    init(@ElementBuilder _ content: @escaping () -> Content) {
        self.content = content
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
                element.borderThickness = borderThickness
            } onChange: {
                Task { @MainActor in
                    self.updateUIElement()
                }
            }
        }
    }
}

extension Border {
    func borderThickness(_ borderThickness: @escaping @autoclosure () -> Thickness) -> Self {
        return _borderThickness(borderThickness)
    }

    private func _borderThickness(_ borderThickness: @escaping () -> Thickness) -> Self {
        withObservationTracking {
            self.borderThickness = borderThickness()
        } onChange: {
            Task { @MainActor in
                self._borderThickness(borderThickness)
            }
        }
        return self
    }
}

extension Element {
    func padding(_ all: @autoclosure @escaping () -> Double = 16.0) -> Border<Self> {
        return Border { self }.borderThickness(
            .init(
                left: all(),
                top: all(),
                right: all(),
                bottom: all()
            )
        )
    }

    func padding(
        left: @autoclosure @escaping () -> Double = 0.0,
        top: @autoclosure @escaping () -> Double = 0.0,
        right: @autoclosure @escaping () -> Double = 0.0,
        bottom: @autoclosure @escaping () -> Double = 0.0
    ) -> Border<Self> {
        return Border { self }.borderThickness(
            .init(
                left: left(),
                top: top(),
                right: right(),
                bottom: bottom()
            )
        )
    }

    func padding(
        horizontal: @autoclosure @escaping () -> Double = 0.0,
        vertical: @autoclosure @escaping () -> Double = 0.0
    ) -> Border<Self> {
        return Border { self }.borderThickness(
            .init(
                left: horizontal(),
                top: vertical(),
                right: horizontal(),
                bottom: vertical()
            )
        )
    }
}

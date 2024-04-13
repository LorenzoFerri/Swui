import Observation
import UWP
import WinUI
import Foundation

public struct Border<Content: Element>: UIElementRepresentable {
    public var element: WinUI.Border?
    let content: Content
    let borderThickness: () -> Thickness
    let backgroundColor: () -> Color

    public init(
        borderThickness: @autoclosure @escaping () -> Thickness = .init(),
        backgroundColor: @autoclosure @escaping () -> Color = .transparent,
        @ElementBuilder _ content: @escaping () -> Content
    ) {
        self.content = content()
        self.borderThickness = borderThickness
        self.backgroundColor = backgroundColor
    }

    public mutating func makeUIElement() -> WinUI.Border? {
        element = WinUI.Border()
        element?.child = content.makeElement()
        updateUIElement()
        return element
    }

    public func updateUIElement() {
        if let element {
            withObservationTracking {
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
    public func border(_ all: @autoclosure @escaping () -> Double = 16.0) -> Border<Self> {
        return Border(borderThickness: .init(
            left: all(),
            top: all(),
            right: all(),
            bottom: all()
        )) { self }
    }

    public func border(
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

    public func border(
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

    public func background(_ backgroundColor: @autoclosure @escaping () -> Color) -> Border<Self> {
        return Border(backgroundColor: backgroundColor()) { self }
    }
}

import Foundation
import Observation
import UWP
import WinUI

public struct ScrollView<Content: Element>: UIElementRepresentable {
    public var element: WinUI.ScrollView?
    var content: () -> Content

    public init(
        _: @escaping @autoclosure () -> Orientation = .vertical,
        @ElementBuilder content: @escaping () -> Content
    ) {
        self.content = content
    }

    public mutating func makeUIElement() -> WinUI.ScrollView? {
        element = WinUI.ScrollView()
        element?.content = content().makeElement()
        updateUIElement()
        return element
    }

    public func updateUIElement() {}
}

public extension Element {
    func scrollable() -> ScrollView<Self> {
        ScrollView { self }
    }
}

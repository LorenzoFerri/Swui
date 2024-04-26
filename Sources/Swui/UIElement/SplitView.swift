import Foundation
import Observation
import UWP
import WinUI

public struct SplitView<Content: Element, Pane: Element>: UIElementRepresentable {
    public var element: WinUI.SplitView?
    var content: () -> Content
    var pane: () -> Pane

    public init(
        _: @escaping @autoclosure () -> Orientation = .vertical,
        @ElementBuilder pane: @escaping () -> Pane,
        @ElementBuilder content: @escaping () -> Content
    ) {
        self.pane = pane
        self.content = content
    }

    public mutating func makeUIElement(context: Context) -> WinUI.SplitView? {
        element = WinUI.SplitView()
        if let element {
            element.content = content().makeElement(context: context)
            element.pane = pane().makeElement(context: context)
            element.isPaneOpen = true
            element.displayMode = .inline
        }
        updateUIElement(context: context)
        return element
    }

    public func updateUIElement(context: Context) {}
}
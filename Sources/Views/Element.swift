import Observation
import WinUI
import Foundation

@MainActor
protocol Element {
    associatedtype Content: Element

    @ElementBuilder
    var content: Self.Content { get }
}

extension Element {
    func _makeElement() -> UIElement? {
        guard !(self is EmptyElement) else { return nil }
        if var u = self as? any UIElementRepresentable {
            return u.makeUIElement()
        } else {
            return content._makeElement()
        }
    }
}

extension Never: Element {
    typealias Content = Never
    var content: Never { fatalError() }
}

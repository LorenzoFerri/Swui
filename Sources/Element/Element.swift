import Observation
import WinUI
import Foundation

@MainActor
protocol Element: Group {
    associatedtype Content: Element

    @ElementBuilder
    var content: Self.Content { get }
}

extension Element {
    func makeElement() -> UIElement? {
        guard !(self is EmptyElement) else { return nil }
        if var u = self as? any UIElementRepresentable {
            return u.makeUIElement()
        } else {
            return content.makeElement()
        }
    }
}

extension Never: Element {
    typealias Content = Never
    var content: Never { fatalError() }
}

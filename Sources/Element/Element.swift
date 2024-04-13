import Observation
import WinUI
import Foundation

@MainActor
protocol Element: Group {
    associatedtype Content: Element

    @ElementBuilder
    var content: Content { get }
}

extension Element {
    func makeElement() -> FrameworkElement? {
        guard !(self is EmptyElement) else { return nil }
        if var u = self as? any UIElementRepresentable {
            return u.makeUIElement()
        }
        return content.makeElement()
    }
}

extension Group where Self: Element {
    func makeGroup() -> [(ElementIdentifier, any Element)] {
        [(ElementIdentifier(Self.self), self)]
    }
}


extension Never: Element {
    typealias Content = Never
    var content: Never { fatalError() }
}

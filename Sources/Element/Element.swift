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
    func makeElement() -> FrameworkElement? {
        guard !(self is EmptyElement) else { return nil }
        if var u = self as? any UIElementRepresentable {
            return u.makeUIElement()
        }
        if let s = self as? any ElementStyler {
            if let element = s.content.makeElement() {
                element.style = s.style
                return element
            }
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

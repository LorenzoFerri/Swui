import Observation
import WinUI
import Foundation

@MainActor
public protocol Element: Group {
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
    public func makeGroup() -> [(ElementIdentifier, any Element)] {
        [(ElementIdentifier(Self.self), self)]
    }
}


extension Never: Element {
    public typealias Content = Never
    public var content: Never { fatalError() }
}

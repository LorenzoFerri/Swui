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
    func makeElement(context: Context) -> FrameworkElement? {
        guard !(self is EmptyElement) else { return nil }
        if var u = self as? any UIElementRepresentable {
            return u.makeUIElement(context: context)
        }
        return content.makeElement(context: context)
    }
}

extension Group where Self: Element {
    public func makeGroup(context: Context) -> [(ElementIdentifier, any Element)] {
        [(ElementIdentifier(Self.self), self)]
    }
}


extension Never: Element {
    public typealias Content = Never
    public var content: Never { fatalError() }
}

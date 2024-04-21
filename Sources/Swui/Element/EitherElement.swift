import WinUI
import Foundation

public protocol EitherProtocol {
    var isFirst: Bool { get }
}

extension EitherElement: EitherProtocol {
    public var isFirst: Bool{
        switch self._element {
            case .first: true
            case .second: false
        }
    }
}

public struct EitherElement<First: Element, Second: Element>: UIElementRepresentable {
    public var element: FrameworkElement?
    let _element: TypeEreasure

    public enum TypeEreasure {
        case first(First)
        case second(Second)
    }

    public init(_ element: TypeEreasure) {
        _element = element
    }

    public func makeUIElement(context: Context) -> FrameworkElement? {
        switch _element {
            case let .first(element): element.makeElement(context: context)
            case let .second(element): element.makeElement(context: context)
        }
    }

    public func updateUIElement(context: Context) {

    }
}
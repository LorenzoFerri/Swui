import WinUI
import Foundation

protocol EitherProtocol {
    var isFirst: Bool { get }
}

extension EitherElement: EitherProtocol {
    var isFirst: Bool{
        switch self._element {
            case .first: true
            case .second: false
        }
    }
}

struct EitherElement<First: Element, Second: Element>: UIElementRepresentable {
    var element: UIElement?
    let _element: TypeEreasure

    enum TypeEreasure {
        case first(First)
        case second(Second)
    }

    init(_ element: TypeEreasure) {
        _element = element
    }

    func makeUIElement() -> UIElement? {
        switch _element {
            case let .first(element): element._makeElement()
            case let .second(element): element._makeElement()
        }
    }

    mutating func updateUIElement() {

    }
}
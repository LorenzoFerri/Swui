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
    var element: FrameworkElement?
    let _element: TypeEreasure

    enum TypeEreasure {
        case first(First)
        case second(Second)
    }

    init(_ element: TypeEreasure) {
        _element = element
    }

    func makeUIElement() -> FrameworkElement? {
        switch _element {
            case let .first(element): element.makeElement()
            case let .second(element): element.makeElement()
        }
    }

    func updateUIElement() {

    }
}
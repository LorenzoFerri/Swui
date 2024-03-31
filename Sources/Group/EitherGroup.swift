import WinUI
import Foundation


extension EitherGroup: EitherProtocol {
    var isFirst: Bool{
        switch self._element {
            case .first: true
            case .second: false
        }
    }
}

struct EitherGroup<First: Group, Second: Group>: Group {
    let _element: TypeEreasure

    enum TypeEreasure {
        case first(First)
        case second(Second)
    }

    init(_ element: TypeEreasure) {
        _element = element
    }

    func makeGroup() -> [any Element] {
        switch _element {
            case let .first(group): group.makeGroup()
            case let .second(group): group.makeGroup()
        }
    }
}
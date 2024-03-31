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

    func makeGroup() -> [(String, any Element)] {
        switch _element {
            case let .first(group): group.makeGroup().map { (id, element) in ("\(Self.self).first+\(id)", element)}
            case let .second(group): group.makeGroup().map { (id, element) in ("\(Self.self).second+\(id)", element)}
        }
    }
}
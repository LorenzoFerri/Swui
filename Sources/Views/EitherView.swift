import WinUI
import Foundation

protocol EitherViewProtocol {
    var isFirst: Bool { get }
}

extension EitherView: EitherViewProtocol {
    var isFirst: Bool{
        switch self._view {
            case .first: true
            case .second: false
        }
    }
}

struct EitherView<First: View, Second: View>: UIViewRepresentable {
    var view: UIElement?
    let _view: TypeEreasure

    enum TypeEreasure {
        case first(First)
        case second(Second)
    }

    init(_ view: TypeEreasure) {
        _view = view
    }

    func makeUIView() -> UIElement? {
        switch _view {
            case let .first(view): view._makeView()
            case let .second(view): view._makeView()
        }
    }

    mutating func updateUIView() {

    }
}
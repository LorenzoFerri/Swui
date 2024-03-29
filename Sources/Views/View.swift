import Observation
import WinUI
import Foundation

@MainActor
protocol View {
    associatedtype Body: View

    @ViewBuilder
    var body: Self.Body { get }
}

extension View {
    func _makeView() -> UIElement? {
        guard !(self is EmptyView) else { return nil }
        if var u = self as? any UIViewRepresentable {
            return u.makeUIView()
        } else {
            return body._makeView()
        }
    }
}

extension Never: View {
    typealias Body = Never
    var body: Never { fatalError() }
}

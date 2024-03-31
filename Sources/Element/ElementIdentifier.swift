struct ElementIdentifier: Hashable {
    var path: String

    init(_ path: String) {
        self.path = path
    }

    init<T>(_ value: T.Type) {
        self.path = "element:\(value)"
    }

    func appending<T>(_ element: T.Type) -> Self {
        .init(path.appendingPathComponent("\(element)"))
    }
    func appending<Value: LosslessStringConvertible>(id: Value) -> Self {
        .init(path.appendingPathComponent(id.description))
    }
}
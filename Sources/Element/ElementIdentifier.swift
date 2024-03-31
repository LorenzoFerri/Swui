struct ElementIdentifier: Hashable {
    var path: String
    var id: String?

    init(_ path: String, _ id: String?) {
        self.path = path
        self.id = id
    }

    init<T>(_ value: T.Type) {
        path = "element:\(value)"
    }

    func appendingPath<T>(_ element: T.Type) -> Self {
        .init(path.appendingPathComponent("\(element)"), id)
    }

    func appendingPath(_ element: String) -> Self {
        .init(path.appendingPathComponent(element), id)
    }

    func withId<Value: LosslessStringConvertible>(id: Value) -> Self {
        if self.id == nil {
            .init(path, "\(id)")
        } else {
            .init(path, self.id!.description.appendingPathComponent("\(id)"))
        }
    }

    func withIndex(index: Int) -> Self {
        if self.id == nil {
            .init(path, "\(index)")
        } else {
            self
        }
    }
}

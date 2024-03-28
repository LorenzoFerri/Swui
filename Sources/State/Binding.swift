
@propertyWrapper
struct Binding<Value> {
    let get: () -> Value
    let set: (Value) -> Void

    var wrappedValue: Value {
        get { get() }
        nonmutating set { set(newValue) }
    }

    var projectedValue: Binding<Value> {
        self
    }

    init(get: @escaping () -> Value, set: @escaping (Value) -> Void) {
        self.get = get
        self.set = set
    }

    static func constant(_ value: Value) -> Self {
        Binding(get: { value }, set: { _ in })
    }
}

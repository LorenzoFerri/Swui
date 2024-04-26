import Observation
@propertyWrapper
@Observable
public class Binding<Value> {
    let get: () -> Value
    let set: (Value) -> Void

    public var wrappedValue: Value {
        get { get() }
        set { set(newValue) }
    }

    public var projectedValue: Binding<Value> {
        self
    }

    init(get: @escaping () -> Value, set: @escaping (Value) -> Void) {
        self.get = get
        self.set = set
    }

    static func constant(_ value: Value) -> Binding<Value> {
        Binding(get: { value }, set: { _ in })
    }
}

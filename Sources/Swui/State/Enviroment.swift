import Observation

public protocol EnviromentProtocol {
    associatedtype Value = Observable
    var resolvedValue: (any Observable)? { get set }
    var key: Value.Type { get }
}


@propertyWrapper
public class Enviroment<Value>: EnviromentProtocol {
    public let key: Value.Type
    public var resolvedValue: (any Observable)?

    public var wrappedValue: Value {
        get {
            if let resolvedValue {
                return resolvedValue as! Value
            } else {
                fatalError("Could not find Enviroment of type: \(key)")
            }
        }
    }

    public init(_ type: Value.Type) {
        self.key = type
    }
}
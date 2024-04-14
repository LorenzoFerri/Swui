@propertyWrapper
class ReferenceType<T> {
    private var _storage: T

    init(wrappedValue: T) {
        _storage = wrappedValue
    }

    var wrappedValue: T {
        _read {
            yield _storage
        }
        _modify {
            yield &_storage
        }
        set {
            _storage = newValue
        }
    }
}

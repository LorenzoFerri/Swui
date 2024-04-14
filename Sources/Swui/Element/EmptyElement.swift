public struct EmptyElement: Element {
    public var content: Never { fatalError() }
}

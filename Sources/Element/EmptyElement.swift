struct EmptyElement: Element {
    var content: Never { fatalError() }
}

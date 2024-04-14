public struct ForEach<Data, Content>: Group where Data: RandomAccessCollection, Content: Group, Data.Element: Identifiable {
    var content: (Data.Element) -> Content
    @Binding var data: Data
}


extension ForEach {
    public func makeGroup() -> [(ElementIdentifier, any Element)] {
        return data.flatMap { element in
            content(element).makeGroup().map { ($0.0.withId(id: "\(element.id)"), $0.1) }
        }
    }

    public init(_ data: Data, @GroupBuilder _ content: @escaping (Data.Element) -> Content) {
        _data = Binding.constant(data)
        self.content = content
    }

    public init(_ data: Binding<Data>, @GroupBuilder _ content: @escaping (Data.Element) -> Content) {
        _data = data
        self.content = content
    }
}

extension ForEach where Data == Range<Int> {
    public init(_ range: Range<Int>, @GroupBuilder _ content: @escaping (Int) -> Content) {
        _data = Binding.constant(range)
        self.content = content
    }
}

extension Int: @retroactive Identifiable {
    public var id: Int { self }
}

extension ForEach where Data == ClosedRange<Int> {
    public init(_ range: ClosedRange<Int>, @GroupBuilder _ content: @escaping (Int) -> Content) {
        _data = Binding.constant(range)
        self.content = content
    }
}

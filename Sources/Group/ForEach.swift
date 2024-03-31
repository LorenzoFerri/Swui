struct ForEach<Data: RandomAccessCollection, Content: Group>: Group {
    func makeGroup() -> [(String, any Element)] {
        data.flatMap { elementBuilder($0).makeGroup() }
    }

    var content: Never { fatalError() }
    var elementBuilder: (Data.Element) -> Content
    var data: Data

    init(_ data: Data, @GroupBuilder content: @escaping (Data.Element) -> Content) {
        self.elementBuilder = content
        self.data = data
    }
}

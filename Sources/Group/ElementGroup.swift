protocol ElementGroup: Group {
    associatedtype Children: Group

    @GroupBuilder
    var children: Self.Children { get }
}

extension Group where Self: ElementGroup {
    func makeGroup() -> [(ElementIdentifier, any Element)] {
        children.makeGroup()
    }
}
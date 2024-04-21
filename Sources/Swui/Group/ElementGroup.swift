public protocol ElementGroup: Group {
    associatedtype Children: Group

    @GroupBuilder
    var children: Self.Children { get }
}

extension Group where Self: ElementGroup {
    public func makeGroup(context: Context) -> [(ElementIdentifier, any Element)] {
        children.makeGroup(context: context)
    }
}
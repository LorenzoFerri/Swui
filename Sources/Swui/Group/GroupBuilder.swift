
@MainActor
@resultBuilder
public enum GroupBuilder {
    public typealias G = Group
    public static func buildBlock<C0: G>(_ c0: C0) -> C0 {
        c0
    }

    public static func buildBlock<C0: G, C1: G>(_ c0: C0, _ c1: C1) -> ElementGroup2<C0, C1> {
        .init(c0, c1)
    }

    public static func buildBlock<C0: G, C1: G, C2: G>(_ c0: C0, _ c1: C1, _ c2: C2) -> ElementGroup3<C0, C1, C2> {
        .init(c0, c1, c2)
    }

    public static func buildBlock<C0: G, C1: G, C2: G, C3: G>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3) -> ElementGroup4<C0, C1, C2, C3> {
        .init(c0, c1, c2, c3)
    }

    public static func buildBlock<C0: G, C1: G, C2: G, C3: G, C4: G>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4) -> ElementGroup5<C0, C1, C2, C3, C4> {
        .init(c0, c1, c2, c3, c4)
    }

    public static func buildBlock<C0: G, C1: G, C2: G, C3: G, C4: G, C5: G>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5) -> ElementGroup6<C0, C1, C2, C3, C4, C5> {
        .init(c0, c1, c2, c3, c4, c5)
    }

    public static func buildBlock<C0: G, C1: G, C2: G, C3: G, C4: G, C5: G, C6: G>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6) -> ElementGroup7<C0, C1, C2, C3, C4, C5, C6> {
        .init(c0, c1, c2, c3, c4, c5, c6)
    }

    public static func buildBlock<C0: G, C1: G, C2: G, C3: G, C4: G, C5: G, C6: G, C7: G>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7) -> ElementGroup8<C0, C1, C2, C3, C4, C5, C6, C7> {
        .init(c0, c1, c2, c3, c4, c5, c6, c7)
    }

    public static func buildBlock<C0: G, C1: G, C2: G, C3: G, C4: G, C5: G, C6: G, C7: G, C8: G>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8) -> ElementGroup9<C0, C1, C2, C3, C4, C5, C6, C7, C8> {
        .init(c0, c1, c2, c3, c4, c5, c6, c7, c8)
    }

    public static func buildOptional<Component: Group>(_ component: Component?) -> EitherGroup<Component, EmptyElement> {
        if let component {
            EitherGroup<Component, EmptyElement>(.first(component))
        } else {
            EitherGroup<Component, EmptyElement>(.second(EmptyElement()))
        }
    }

    public static func buildEither<First: Group, Second: Group>(first component: First) -> EitherGroup<First, Second> {
        EitherGroup(.first(component))
    }

    public static func buildEither<First: Group, Second: Group>(second component: Second) -> EitherGroup<First, Second> {
        EitherGroup(.second(component))
    }
}

public struct ElementGroup1<E0: Group>: Group {
    var e0: E0

    init(_ e0: E0) {
        self.e0 = e0
    }

    public func makeGroup(context: Context) -> [(ElementIdentifier, any Element)] { e0.makeGroup(context: context) }
}

public struct ElementGroup2<E0: Group, E1: Group>: Group {
    var e0: E0
    var e1: E1

    init(_ e0: E0, _ e1: E1) {
        self.e0 = e0
        self.e1 = e1
    }

    public func makeGroup(context: Context) -> [(ElementIdentifier, any Element)] { e0.makeGroup(context: context) + e1.makeGroup(context: context) }
}

public struct ElementGroup3<E0: Group, E1: Group, E2: Group>: Group {
    var e0: E0
    var e1: E1
    var e2: E2

    init(_ e0: E0, _ e1: E1, _ e2: E2) {
        self.e0 = e0
        self.e1 = e1
        self.e2 = e2
    }

    public func makeGroup(context: Context) -> [(ElementIdentifier, any Element)] { e0.makeGroup(context: context) + e1.makeGroup(context: context) + e2.makeGroup(context: context) }
}

public struct ElementGroup4<E0: Group, E1: Group, E2: Group, E3: Group>: Group {
    var e0: E0
    var e1: E1
    var e2: E2
    var e3: E3

    init(_ e0: E0, _ e1: E1, _ e2: E2, _ e3: E3) {
        self.e0 = e0
        self.e1 = e1
        self.e2 = e2
        self.e3 = e3
    }

    public func makeGroup(context: Context) -> [(ElementIdentifier, any Element)] { e0.makeGroup(context: context) + e1.makeGroup(context: context) + e2.makeGroup(context: context) + e3.makeGroup(context: context) }
}

public struct ElementGroup5<E0: Group, E1: Group, E2: Group, E3: Group, E4: Group>: Group {
    var e0: E0
    var e1: E1
    var e2: E2
    var e3: E3
    var e4: E4

    init(_ e0: E0, _ e1: E1, _ e2: E2, _ e3: E3, _ e4: E4) {
        self.e0 = e0
        self.e1 = e1
        self.e2 = e2
        self.e3 = e3
        self.e4 = e4
    }

    public func makeGroup(context: Context) -> [(ElementIdentifier, any Element)] { e0.makeGroup(context: context) + e1.makeGroup(context: context) + e2.makeGroup(context: context) + e3.makeGroup(context: context) + e4.makeGroup(context: context) }
}

public struct ElementGroup6<E0: Group, E1: Group, E2: Group, E3: Group, E4: Group, E5: Group>: Group {
    var e0: E0
    var e1: E1
    var e2: E2
    var e3: E3
    var e4: E4
    var e5: E5

    init(_ e0: E0, _ e1: E1, _ e2: E2, _ e3: E3, _ e4: E4, _ e5: E5) {
        self.e0 = e0
        self.e1 = e1
        self.e2 = e2
        self.e3 = e3
        self.e4 = e4
        self.e5 = e5
    }

    public func makeGroup(context: Context) -> [(ElementIdentifier, any Element)] { e0.makeGroup(context: context) + e1.makeGroup(context: context) + e2.makeGroup(context: context) + e3.makeGroup(context: context) + e4.makeGroup(context: context) + e5.makeGroup(context: context) }
}

public struct ElementGroup7<E0: Group, E1: Group, E2: Group, E3: Group, E4: Group, E5: Group, E6: Group>: Group {
    var e0: E0
    var e1: E1
    var e2: E2
    var e3: E3
    var e4: E4
    var e5: E5
    var e6: E6

    init(_ e0: E0, _ e1: E1, _ e2: E2, _ e3: E3, _ e4: E4, _ e5: E5, _ e6: E6) {
        self.e0 = e0
        self.e1 = e1
        self.e2 = e2
        self.e3 = e3
        self.e4 = e4
        self.e5 = e5
        self.e6 = e6
    }

    public func makeGroup(context: Context) -> [(ElementIdentifier, any Element)] { e0.makeGroup(context: context) + e1.makeGroup(context: context) + e2.makeGroup(context: context) + e3.makeGroup(context: context) + e4.makeGroup(context: context) + e5.makeGroup(context: context) + e6.makeGroup(context: context) }
}

public struct ElementGroup8<E0: Group, E1: Group, E2: Group, E3: Group, E4: Group, E5: Group, E6: Group, E7: Group>: Group {
    var e0: E0
    var e1: E1
    var e2: E2
    var e3: E3
    var e4: E4
    var e5: E5
    var e6: E6
    var e7: E7

    init(_ e0: E0, _ e1: E1, _ e2: E2, _ e3: E3, _ e4: E4, _ e5: E5, _ e6: E6, _ e7: E7) {
        self.e0 = e0
        self.e1 = e1
        self.e2 = e2
        self.e3 = e3
        self.e4 = e4
        self.e5 = e5
        self.e6 = e6
        self.e7 = e7
    }

    public func makeGroup(context: Context) -> [(ElementIdentifier, any Element)] { e0.makeGroup(context: context) + e1.makeGroup(context: context) + e2.makeGroup(context: context) + e3.makeGroup(context: context) + e4.makeGroup(context: context) + e5.makeGroup(context: context) + e6.makeGroup(context: context) + e7.makeGroup(context: context) }
}

public struct ElementGroup9<E0: Group, E1: Group, E2: Group, E3: Group, E4: Group, E5: Group, E6: Group, E7: Group, E8: Group>: Group {
    var e0: E0
    var e1: E1
    var e2: E2
    var e3: E3
    var e4: E4
    var e5: E5
    var e6: E6
    var e7: E7
    var e8: E8

    init(_ e0: E0, _ e1: E1, _ e2: E2, _ e3: E3, _ e4: E4, _ e5: E5, _ e6: E6, _ e7: E7, _ e8: E8) {
        self.e0 = e0
        self.e1 = e1
        self.e2 = e2
        self.e3 = e3
        self.e4 = e4
        self.e5 = e5
        self.e6 = e6
        self.e7 = e7
        self.e8 = e8
    }

    public func makeGroup(context: Context) -> [(ElementIdentifier, any Element)] { e0.makeGroup(context: context) + e1.makeGroup(context: context) + e2.makeGroup(context: context) + e3.makeGroup(context: context) + e4.makeGroup(context: context) + e5.makeGroup(context: context) + e6.makeGroup(context: context) + e7.makeGroup(context: context) + e8.makeGroup(context: context) }
}

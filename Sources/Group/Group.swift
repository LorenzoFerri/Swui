protocol Group {
    func makeGroup() -> [(String, any Element)]
}

extension Group where Self: Element {
    func makeGroup() -> [(String, any Element)] {
        [("\(Self.self)", self)]
    }
}



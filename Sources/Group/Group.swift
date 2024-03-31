import Foundation

@MainActor
protocol Group {
    func makeGroup() -> [(ElementIdentifier, any Element)]
}
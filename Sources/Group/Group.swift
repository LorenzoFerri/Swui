import Foundation

@MainActor
public protocol Group {
    func makeGroup() -> [(ElementIdentifier, any Element)]
}
import Foundation

@MainActor
public protocol Group {
    func makeGroup(context: Context) -> [(ElementIdentifier, any Element)]
}
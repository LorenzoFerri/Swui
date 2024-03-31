import Foundation

protocol Group {
    func makeGroup() -> [(ElementIdentifier, any Element)]
}
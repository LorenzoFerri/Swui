import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxMacros

public enum PropertyModifierDeclError: CustomStringConvertible, Error {
    case onlyApplicableProperties

    public var description: String {
        switch self {
        case .onlyApplicableProperties:
            "@PropertyModifier can only be applied to properties."
       }
    }
}

public struct PropertyModifierMacro: PeerMacro {
    public static func expansion(
        of node: SwiftSyntax.AttributeSyntax,
        providingPeersOf declaration: some SwiftSyntax.DeclSyntaxProtocol,
        in context: some SwiftSyntaxMacros.MacroExpansionContext
    ) throws -> [SwiftSyntax.DeclSyntax] {
        print(node)
        print(declaration)
        print(context)
        return []
    }
}

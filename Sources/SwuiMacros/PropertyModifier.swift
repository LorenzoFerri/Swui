import SwiftCompilerPlugin
import SwiftSyntaxMacros

@attached(peer)
public macro PropertyModifier() = #externalMacro(module: "SwuiMacros", type: "PropertyModifierMacro")
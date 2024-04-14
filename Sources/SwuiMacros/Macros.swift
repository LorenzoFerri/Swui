import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct SwuiPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        PropertyModifierMacro.self,
    ]
}
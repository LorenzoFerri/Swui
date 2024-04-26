import Foundation
import Observation
import UWP
import WinAppSDK
import WindowsFoundation
import WinSDK
import WinUI

public struct TreeView<Data>: UIElementRepresentable {
    public var element: WinUI.TreeView?
    let content: (Data) -> String
    let data: () -> [Data]
    let keyPath: KeyPath<Data, [Data]>

    public init(
        data: @escaping @autoclosure () -> [Data],
        keyPath: KeyPath<Data, [Data]>,
        _ content: @escaping (Data) -> String
    ) {
        self.content = content
        self.keyPath = keyPath
        self.data = data
    }

    public mutating func makeUIElement(context: Context) -> WinUI.TreeView? {
        element = WinUI.TreeView()
        if let element {
            for item in data() {
                var node = TreeViewNode()
                node.content = content(item)
                buildTree(context: context, for: item[keyPath: keyPath], root: &node)
                element.rootNodes.append(node)
            }
        }
        updateUIElement(context: context)
        return element
    }

    func buildTree(context: Context, for data: [Data], root: inout TreeViewNode) {
        for item in data {
            var node = TreeViewNode()
            node.content = content(item)
            buildTree(context: context, for: item[keyPath: keyPath], root: &node)
            root.children.append(node)
        }
    }

    public func updateUIElement(context: Context) {
        // if let element {
        //     withObservationTracking {} onChange: {
        //         Task { @MainActor in
        //             self.updateUIElement(context: context)
        //         }
        //     }
        // }
    }
}

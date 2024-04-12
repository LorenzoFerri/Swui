import WinUI

class PanelState {
    var renderedElements: [ElementIdentifier] = []
    var elementsMap: [ElementIdentifier:UIElement] = [:]
}

@MainActor
protocol Panel: UIElementRepresentable where Self.UIElementType: WinUI.Panel {
    var state: PanelState { get set }
    func makePanel<Content: Group>(_ content: () -> Content)
    func updatePanel<Content: Group>(_ content: () -> Content)
}

extension Panel {
    internal func makePanel<Content: Group>(_ content: () -> Content) {
        var index = 0
        for (id, child) in content().makeGroup() {
            let id = id.withIndex(index: index)
            if let element = child.makeElement() {
                self.element?.children.append(element)
                state.renderedElements.append(id)
                state.elementsMap[id] = element
            }
            index += 1
        }
    }

    internal func updatePanel<Content: Group>(_ content: () -> Content) {
        var index = 0
        var elementsToRender: [ElementIdentifier] = []
        for (id, child) in content().makeGroup() {
            let id = id.withIndex(index: index)
            if !state.renderedElements.contains(id) {
                if let element = child.makeElement() {
                    state.elementsMap[id] = element
                    elementsToRender.append(id)
                }
            } else {
                elementsToRender.append(id)
            }
            index += 1
        }
        let operations = elementsToRender.difference(from: state.renderedElements)
        for operation in operations {
            switch operation {
            case let .insert(offset: offset, element: elementKey, _):
                element?.children.insertAt(UInt32(offset), state.elementsMap[elementKey])
            case let .remove(offset: offset, _, _):
                element?.children.removeAt(UInt32(offset))
            }
        }
        state.renderedElements = elementsToRender
    }
}

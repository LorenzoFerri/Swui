import WinUI

class PanelState {
    var renderedElements: [ElementIdentifier] = []
    var elementsMap: [ElementIdentifier:FrameworkElement] = [:]
}

@MainActor
protocol Panel: UIElementRepresentable {
    var state: PanelState { get set }
    func append(_ element: FrameworkElement)
    func insertAt(_ position: Int, _ element: FrameworkElement)
    func removeAt(_ position: Int)
    func makeChildElement(_ element: any Element, _ id: ElementIdentifier) -> FrameworkElement?
}

extension Panel {
    func makeChildElement(_ element: any Element, _ id: ElementIdentifier) -> FrameworkElement? {
        return element.makeElement()
    }

    internal func makePanel<Content: Group>(_ content: () -> Content) {
        var index = 0
        for (id, child) in content().makeGroup() {
            let id = id.withIndex(index: index)
            if let element = makeChildElement(child, id) {
                append(element)
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
                insertAt(offset, state.elementsMap[elementKey]!)
            case let .remove(offset: offset, _, _):
                removeAt(offset)
            }
        }
        state.renderedElements = elementsToRender
    }
}

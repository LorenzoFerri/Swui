import WinUI

class PanelState {
    var renderedElements: [ElementIdentifier] = []
    var elementsMap: [ElementIdentifier: FrameworkElement] = [:]
}

@MainActor
protocol Panel: UIElementRepresentable {
    var state: PanelState { get set }
    func append(_ element: FrameworkElement)
    func insertAt(_ position: Int, _ element: FrameworkElement)
    func removeAt(_ position: Int)
    func makeChildElement(_ element: any Element, _ id: ElementIdentifier, context: Context) -> FrameworkElement?
}

extension Panel {
    func makeChildElement(_ element: any Element, _: ElementIdentifier, context: Context) -> FrameworkElement? {
        return element.makeElement(context: context)
    }

    func makePanel<Content: Group>(_ content: () -> Content, context: Context) {
        var index = 0
        for (id, child) in content().makeGroup(context: context) {
            let id = id.withIndex(index: index)
            if let element = makeChildElement(child, id, context: context) {
                append(element)
                state.renderedElements.append(id)
                state.elementsMap[id] = element
            }
            index += 1
        }
    }

    func updatePanel<Content: Group>(_ content: () -> Content, context: Context) {
        var index = 0
        var elementsToRender: [ElementIdentifier] = []
        for (id, child) in content().makeGroup(context: context) {
            let id = id.withIndex(index: index)
            if !state.renderedElements.contains(id) {
                if let element = makeChildElement(child, id, context: context) {
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

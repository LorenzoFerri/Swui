import WinUI

class PanelState {
    var eitherElementMap: [Int: Bool] = [:]
    var emptyElementMap: [Int: Bool] = [:]
    var renderedElements: [Int] = []
}

@MainActor
protocol Panel: UIElementRepresentable where Self.UIElementType: WinUI.Panel {
    var state: PanelState { get set }
    func makePanel<Content: Group>(_ content: () -> Content)
    func updatePanel<Content: Group>(_ content: () -> Content)
}

extension Panel {
    func makePanel<Content: Group>(_ content: () -> Content) {
        var i = 0
        for child in content().makeGroup() {
            if let eitherElement = child as? any EitherProtocol {
                state.eitherElementMap[i] = eitherElement.isFirst
            }
            if let element = child._makeElement() {
                self.element?.children.append(element)
                state.renderedElements.append(i)
                state.emptyElementMap[i] = false
            } else {
                state.emptyElementMap[i] = true
            }
            i += 1
        }
    }

    func updatePanel<Content: Group>(_ content: () -> Content) {
        var i = 0
        var elementsToRender: [Int] = []
        var elementsMap: [Int: UIElement] = [:]
        var elementsToSet: [Int] = []
        for child in content().makeGroup() {
            if let eitherElement = child as? any EitherProtocol {
                if state.eitherElementMap[i] != eitherElement.isFirst {
                    if let element = child._makeElement() {
                        if state.renderedElements.contains(i) {
                            elementsToSet.append(i)
                        }
                        elementsToRender.append(i)
                        elementsMap[i] = element
                        state.emptyElementMap[i] = false
                    } else {
                        state.emptyElementMap[i] = true
                    }
                    state.eitherElementMap[i] = eitherElement.isFirst
                } else {
                    if !(state.emptyElementMap[i]!) {
                        elementsToRender.append(i)
                    }
                }
            } else {
                elementsToRender.append(i)
            }
            i += 1
        }
        let operations = elementsToRender.difference(from: state.renderedElements)
        for operation in operations {
            switch operation {
            case let .insert(offset: offset, element: elementKey, _):
                element?.children.insertAt(UInt32(offset), elementsMap[elementKey])
            case let .remove(offset: offset, _, _):
                element?.children.removeAt(UInt32(offset))
            }
        }
        for elementKey in elementsToSet {
            if let index = elementsToRender.firstIndex(of: elementKey) {
                element?.children.setAt(UInt32(index), elementsMap[elementKey])
            }
        }
        state.renderedElements = elementsToRender
    }
}

import Observation
import WinUI

public struct NavigationView<Content: Group>: Panel {
    var state = PanelState()
    public var element: WinUI.NavigationView?
    var content: () -> Content
    var title: (() -> String)? = nil
    @ReferenceType var contentMap: [ElementIdentifier: () -> any Element] = [:]

    public init(@GroupBuilder content: @escaping () -> Content) {
        self.content = content
    }

    public init(_ title: @escaping @autoclosure () -> String, @GroupBuilder content: @escaping () -> Content) {
        self.content = content
        self.title = title
    }

    func append(_ element: WinUI.FrameworkElement) {
        self.element?.menuItems.append(element)
    }

    func insertAt(_ position: Int, _ element: WinUI.FrameworkElement) {
        self.element?.menuItems.insertAt(UInt32(position), element)
    }

    func removeAt(_ position: Int) {
        element?.menuItems.removeAt(UInt32(position))
    }

    func makeChildElement(_ element: any Element, _ id: ElementIdentifier) -> FrameworkElement? {
        if let navigationViewItem = element as? any NavigationItemProtocol {
            contentMap[id] = navigationViewItem.navigationContent
            return element.makeElement()
        }
        return nil
    }

    public mutating func makeUIElement() -> WinUI.NavigationView? {
        element = WinUI.NavigationView()
        if let element {
            if let title = title?() {
                element.paneTitle = title
            }
            element.isSettingsVisible = false

            element.selectionChanged.addHandler { [self] view, args in
                if let selected = args?.selectedItem as? UIElement {
                    if let id = state.elementsMap.first(where: {
                        $0.value == selected
                    })?.key {
                        view?.content = contentMap[id]?().makeElement()
                    }
                }
            }
        }
        makePanel(content)
        if let first = state.renderedElements.first {
            element?.selectedItem = state.elementsMap[first]
        }
        updateUIElement()
        return element
    }

    public func updateUIElement() {
        if element != nil {
            withObservationTracking {
                updatePanel(content)
            } onChange: {
                Task { @MainActor in
                    self.updateUIElement()
                }
            }
        }
    }
}

public protocol NavigationItemProtocol: Element {
    associatedtype NavigationContent: Element
    var navigationContent: () -> NavigationContent { get set }
}

public struct NavigationViewItem<Content: Element>: UIElementRepresentable, NavigationItemProtocol {
    public var element: WinUI.NavigationViewItem?
    var value: () -> String
    public var navigationContent: () -> Content
    var icon: Glyph?

    public init(title value: @autoclosure @escaping () -> String, icon: Glyph? = nil, content: @autoclosure @escaping () -> Content) {
        self.value = value
        self.icon = icon
        navigationContent = content
    }

    public mutating func makeUIElement() -> WinUI.NavigationViewItem? {
        element = WinUI.NavigationViewItem()
        updateUIElement()
        return element
    }

    public func updateUIElement() {
        if let element {
            withObservationTracking {
                element.content = value()
                if let glyph = self.icon?.rawValue {
                    element.icon = {
                        let icon = FontIcon()
                        icon.glyph = glyph
                        return icon
                    }()
                }
            } onChange: {
                Task { @MainActor in
                    self.updateUIElement()
                }
            }
        }
    }
}

extension Element {
    public func navigationItem(_ title: String, glyph: Glyph? = nil) -> NavigationViewItem<Self> {
        NavigationViewItem(title: title, icon: glyph, content: self)
    }
}

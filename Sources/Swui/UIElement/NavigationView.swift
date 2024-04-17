import Observation
import WinUI

public struct NavigationView<Content: Group>: Panel {
    var state = PanelState()
    public var element: WinUI.NavigationView?
    var content: () -> Content
    var title: (() -> String)? = nil
    @State var paneDisplayMode: NavigationViewPaneDisplayMode = .auto
    @ReferenceType var contentMap: [ElementIdentifier: () -> any Element] = [:]
    @ReferenceType var titleMap: [ElementIdentifier: () -> String] = [:]

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
            titleMap[id] = navigationViewItem.title
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
                        view?.header = titleMap[id]!()
                    }
                }
            }
        }
        makePanel(content)
        if let first = state.renderedElements.first {
            element?.selectedItem = state.elementsMap[first]
            element?.header = titleMap[first]!()
        }
        updateUIElement()
        return element
    }

    public func updateUIElement() {
        if let element {
            withObservationTracking {
                updatePanel(content)
                element.paneDisplayMode = paneDisplayMode
            } onChange: {
                Task { @MainActor in
                    self.updateUIElement()
                }
            }
        }
    }
}

public extension NavigationView {
    func paneDisplayMode(
        _ paneDisplayMode: @autoclosure @escaping () -> NavigationViewPaneDisplayMode
    ) -> Self {
        withObservationTracking {
            self.paneDisplayMode = paneDisplayMode()
        } onChange: {
            Task { @MainActor in
                self.paneDisplayMode(paneDisplayMode())
            }
        }
        return self
    }
}

public protocol NavigationItemProtocol: Element {
    associatedtype NavigationContent: Element
    var navigationContent: () -> NavigationContent { get set }
    var title: () -> String { get set }
}

public struct NavigationViewItem<Content: Element>: UIElementRepresentable, NavigationItemProtocol {
    public var element: WinUI.NavigationViewItem?
    public var title: () -> String
    public var navigationContent: () -> Content
    var icon: Glyph?

    public init(title: @autoclosure @escaping () -> String, icon: Glyph? = nil, content: @autoclosure @escaping () -> Content) {
        self.title = title
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
                element.content = title()
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

public extension Element {
    func navigationItem(_ title: String, glyph: Glyph? = nil) -> NavigationViewItem<Self> {
        NavigationViewItem(title: title, icon: glyph, content: self)
    }
}

import Observation
import WinUI

struct NavigationView<Content: Group>: UIElementRepresentable {
    var element: WinUI.NavigationView?
    var content: () -> Content
    var title: (() -> String)? = nil
    @ReferenceType var navigationItems: [ElementIdentifier] = []
    @ReferenceType var itemsMap: [ElementIdentifier: UIElement] = [:]
    @ReferenceType var contentMap: [ElementIdentifier: () -> any Element] = [:]

    init(@GroupBuilder content: @escaping () -> Content) {
        self.content = content
    }

    init(_ title: @escaping @autoclosure () -> String, @GroupBuilder content: @escaping () -> Content) {
        self.content = content
        self.title = title
    }

    mutating func makeUIElement() -> WinUI.NavigationView? {
        element = WinUI.NavigationView()
        if let element {
            if let title = title?() {
                element.paneTitle = title
            }
            element.isSettingsVisible = false

            element.selectionChanged.addHandler { [self] view, args in
                if let selected = args?.selectedItem as? UIElement {
                    if let id = itemsMap.first(where: {
                        $0.value == selected
                    })?.key {
                        view?.content = contentMap[id]?().makeElement()
                    }
                }
            }

            var index = 0
            for (id, child) in content().makeGroup() {
                let id = id.withIndex(index: index)
                if let navigationViewItem = child as? any NavigationItemProtocol {
                    if let itemElement = navigationViewItem.makeElement() {
                        element.menuItems.append(itemElement)
                        navigationItems.append(id)
                        itemsMap[id] = itemElement
                        contentMap[id] = navigationViewItem.navigationContent
                    }
                }
                index += 1
            }
            
        }
        return element
    }

    func updateUIElement() {
    }
}

protocol NavigationItemProtocol: Element {
    associatedtype NavigationContent: Element
    var navigationContent: () -> NavigationContent { get set }
}

struct NavigationViewItem<Content: Element>: UIElementRepresentable, NavigationItemProtocol {
    var element: WinUI.NavigationViewItem?
    var value: () -> String
    var navigationContent: () -> Content
    var icon: Glyph?

    init(title value: @autoclosure @escaping () -> String, icon: Glyph? = nil, content: @autoclosure @escaping () -> Content) {
        self.value = value
        self.icon = icon
        navigationContent = content
    }

    mutating func makeUIElement() -> WinUI.NavigationViewItem? {
        element = WinUI.NavigationViewItem()
        updateUIElement()
        return element
    }

    func updateUIElement() {
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
    func navigationItem(_ title: String, glyph: Glyph? = nil) -> NavigationViewItem<Self> {
        NavigationViewItem(title: title, icon: glyph, content: self)
    }
}

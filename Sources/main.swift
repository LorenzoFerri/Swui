import Foundation
import Observation
import UWP
import WinAppSDK
import WindowsFoundation
import WinUI

@main
public class PreviewApp: SwiftApplication {
    lazy var window: Window = {
        let window = Window()
        window.content = UIHostingController(rootView: ContentView())
        return window
    }()

    override public func onLaunched(_: WinUI.LaunchActivatedEventArgs) {
        try! window.activate()
    }
}

class UIHostingController<Content>: Frame
    where Content: View
{
    init(rootView view: Content) {
        super.init()
        content = view._makeView()
    }
}

struct ContentView: View {
    var body: some View {
        StackPanel {
            TextBlock("Hello world")
            TextBlock("Hello world")
            Button("Bottone") {
                print("Hello")
            }
        }
    }
}

protocol View {
    associatedtype Body: View

    @ViewBuilder
    var body: Self.Body { get }
}

extension View {
    func _makeView() -> UIElement {
        if let u = self as? any UIViewRepresentable {
            return u.makeUIView()
        } else {
            return body._makeView()
        }
    }
}

struct VariadicView<each Content: View>: View {
    var body: Never { fatalError() }
    var views: (repeat each Content)

    init(_ views: repeat each Content) {
        self.views = (repeat each views)
    }
}

@resultBuilder
enum ViewBuilder {
    static func buildBlock() -> EmptyView {
        .init()
    }

    static func buildBlock(_ content: Never) -> Never {
        fatalError()
    }
    
    static func buildBlock<each V: View>(_ views: repeat each V) -> VariadicView<repeat each V> {
        .init(repeat each views)
    }
}

struct EmptyView: View {
    var body: Never { fatalError() }
}

extension Never: View {
    typealias Body = Never
    var body: Never { fatalError() }
}

protocol UIViewRepresentable: View
    where Self.Body == Never
{
    associatedtype UIViewType: UIElement

    func makeUIView() -> Self.UIViewType
    func updateUIView(view: Self.UIViewType) -> Void
}

struct TextBlock: UIViewRepresentable {
    var body: Never { fatalError() }

    let text: String
    let verticalAlignment: VerticalAlignment
    let horizontalAlignment: HorizontalAlignment

    init(
        _ text: String,
        verticalAlignment: VerticalAlignment = .center,
        horizontalAlignment: HorizontalAlignment = .center
    ) {
        self.text = text
        self.horizontalAlignment = horizontalAlignment
        self.verticalAlignment = verticalAlignment
    }

    func makeUIView() -> WinUI.TextBlock {
        let textBlock = WinUI.TextBlock()
        textBlock.text = text
        textBlock.verticalAlignment = verticalAlignment
        textBlock.horizontalAlignment = horizontalAlignment
        return textBlock
    }

    func updateUIView(view _: WinUI.TextBlock) {}
}

struct StackPanel<each Content: View>: UIViewRepresentable  {
    var body: Never { fatalError() }

    let content: VariadicView<repeat each Content>
    let orientation: Orientation
    let verticalAlignment: VerticalAlignment
    let horizontalAlignment: HorizontalAlignment
    let spacing: Double

    init(
        orientation: Orientation = .vertical,
        verticalAlignment: VerticalAlignment = .center,
        horizontalAlignment: HorizontalAlignment = .center,
        spacing: Double = 20,
        @ViewBuilder content: () -> VariadicView<repeat each Content>
    ) {
        self.content = content()
        
        self.orientation = orientation
        self.horizontalAlignment = horizontalAlignment
        self.verticalAlignment = verticalAlignment
        self.spacing = spacing
    }

    func makeUIView() -> WinUI.StackPanel {
        let stackPanel = WinUI.StackPanel()
        stackPanel.orientation = orientation
        stackPanel.verticalAlignment = verticalAlignment
        stackPanel.horizontalAlignment = horizontalAlignment
        stackPanel.spacing = spacing
        // for view in repeat each content.views {
        //     stackPanel.children.append(view._makeView())
        // }
        return stackPanel
    }

    func updateUIView(view _: WinUI.StackPanel) {}
}

struct Button: UIViewRepresentable {
    var body: Never { fatalError() }
    let text: String
    let onClick: (() -> Void)?

    init(_ text: String, onClick: (() -> Void)? = nil) {
        self.text = text
        self.onClick = onClick
    }

    func makeUIView() -> WinUI.Button {
        let button = WinUI.Button()
        let textBlock = WinUI.TextBlock()
        button.content = textBlock
        textBlock.text = text

        if let onClick = onClick {
            button.click.addHandler { _, _ in
                onClick()
            }
        }
        return button
    }

    func updateUIView(view _: WinUI.Button) {}
}

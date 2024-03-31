import WinUI

@main
public class PreviewApp: SwiftApplication {
    @MainActor lazy var window: Window = {
        let window = Window()
        window.content = UIHostingController(rootElement: ToggleExample())
        return window
    }()

    override public func onLaunched(_: WinUI.LaunchActivatedEventArgs) {
        Task { @MainActor in
            try! window.activate()
        }
    }
}

struct Demo: Element {
    var content: some Element {
        StackPanel {
            TextBlock("Demos:")
            TextBlock("Demos:")
            HelloWorld()
            CounterExample()
            EditExample()
            ToggleExample()
        }
    }
}
// }

struct HelloWorld: Element {
    var content: some Element {
        TextBlock("Hello World!")
    }
}

struct CounterExample: Element {
    @State var count = 0

    var content: some Element {
        StackPanel(orientation: .horizontal) {
            Button("-") { count -= 1 }
            TextBlock("The count is: \(count)")
            Button("+") { count += 1 }
        }
    }
}

struct EditExample: Element {
    @State var name = "Lorenzo"
    var content: some Element {
        StackPanel {
            TextBox($name)
            TextBlock(name)
        }
    }
}

struct ToggleExample: Element {
    @State var isEnabled = false
    @State var x = 0

    var content: some Element {
        StackPanel {
            Button("+") { x += 1 }
            ToggleSwitch($isEnabled)
            ForEach(0...x) { i in
                if isEnabled {
                    CounterExample()
                }
            }
        }
    }
}

struct ForEachExample: Element {
    @State var x = 0
    
    var content: some Element {
        StackPanel { 
            Button("+") { x += 1 }
            ForEach(1...3) { _ in
                if x < 2 {
                    ForEach(1...3) { _ in
                        TextBlock(x)
                    }
                }
            }
        }
    }
}

import WinUI

@main
public class PreviewApp: SwiftApplication {
    @MainActor lazy var window: Window = {
        let window = Window()
        window.content = UIHostingController(rootElement: Demo())
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
            HelloWorld()
            CounterExample()
            EditExample()
            ToggleExample()
        }
    }
}

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
    var content: some Element {
        StackPanel {
            ToggleSwitch($isEnabled)
            if isEnabled {
                TextBlock("I'm on")
            } else {
                TextBlock("I'm off")
            }
            if isEnabled {
                CounterExample()
            }
            if isEnabled {
                HelloWorld()
            }
            if isEnabled {
                TextBlock("I'm on")
            } else {
                TextBlock("I'm off")
            }
            TextBlock("Cose")
        }
    }
}

struct ForEachExample: Element {
    var content: some Element {
        StackPanel {  
            ForEach(1...5) { i in
                CounterExample()
            }
            CounterExample()
        }
    }
}

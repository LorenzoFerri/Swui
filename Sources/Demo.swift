import UWP
import WinUI
@main
public class PreviewApp: SwiftApplication {
    @MainActor lazy var window: Window = {
        let window = Window()
        window.systemBackdrop = MicaBackdrop()
        window.content = UIHostingController(rootElement: Demo())
        window.extendsContentIntoTitleBar = true
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
        NavigationView("Examples") {
            CounterExample()
                .navigationItem("Counter", glyph: .calculator)
            ToggleExample()
                .navigationItem("Toggle", glyph: .toggleLeft)
            EditExample()
                .navigationItem("Edit", glyph: .edit)
        }
    }
}

struct CounterExample: Element {
    @State var count = 0
    var content: some Element {
        StackPanel(orientation: .horizontal) {
            Button("-") { count -= 1 }
            TextBlock(count)
            Button("+") { count += 1 }
        }
    }
}

struct ToggleExample: Element {
    @State var isOn = false
    var content: some Element {
        StackPanel {
            ToggleSwitch($isOn)
            if isOn {
                TextBlock("I'm on!")
            }
        }
    }
}

struct EditExample: Element {
    @State var text = "Hello world!"
    var content: some Element {
        StackPanel {
            TextBox($text)
            TextBlock(text)
        }
    }
}

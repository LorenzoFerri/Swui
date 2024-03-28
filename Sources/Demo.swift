import WinUI

@main
public class PreviewApp: SwiftApplication {
    @MainActor lazy var window: Window = {
        let window = Window()
        window.content = UIHostingController(rootView: Demo())
        return window
    }()

    override public func onLaunched(_: WinUI.LaunchActivatedEventArgs) {
        Task { @MainActor in
            try! window.activate()
        }
    }
}

struct Demo: View {
    var body: some View {
        StackPanel {
            TextBlock("Demos:")
            HelloWorld()
            CounterExample()
            EditExample()
            ToggleExample()
        }
    }
}

struct HelloWorld: View {
    var body: some View {
        TextBlock("Hello World!")
    }
}

struct CounterExample: View {
    @State var count = 0

    var body: some View {
        StackPanel(orientation: .horizontal) {
            Button("-") { count -= 1 }
            TextBlock(count)
            Button("+") { count += 1 }
        }
    }
}

struct EditExample: View {
    @State var name = "Lorenzo"
    var body: some View {
        StackPanel {
            TextBox($name)
            TextBlock(name)
        }
    }
}

struct ToggleExample: View {
    @State var isEnabled = true
    var body: some View {
        StackPanel {
            ToggleSwitch($isEnabled)
            if isEnabled {
                TextBlock("I'm on")
            }
        }
    }
}
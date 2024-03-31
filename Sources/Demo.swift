import WinUI
import UWP
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
                .color(Color(a: 1, r: 1, g: 0, b: 0))
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

    var content: some Element {
        StackPanel {
            ToggleSwitch($isEnabled)
            if isEnabled {
                TextBlock("I'm on")
            } else {
                TextBlock("I'm off")
            }
        }
    }
}

struct Person: Identifiable {
    let firstName: String
    let lastName: String
    var id: String {
        "\(firstName) \(lastName)"
    }
}

struct ForEachExample: Element {
    @State var people: [Person] = [
        Person(firstName: "Lorenzo", lastName: "Ferri"),
        Person(firstName: "Alessio", lastName: "Buratti"),
    ]
    
    var content: some Element {
        StackPanel { 
            Button("Shuffle!") { 
                people.shuffle()
            }
            MyGroup(people: people)
        }
    }
}

struct MyGroup: ElementGroup {
    var people: [Person]

    var children: some Group {
        ForEach(people) { person in
            TextBlock("\(person.id)")       
        }
    }
}


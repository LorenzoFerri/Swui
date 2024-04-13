import Swui

@main
struct MyApp: App {
    var content: some Scene {
        Window {
            Demo()
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
            ForEachExample()
                .navigationItem("ForEach", glyph: .list)
        }
    }
}

struct CounterExample: Element {
    @State var count = 0
    var content: some Element {
        StackPanel(.horizontal) {
            Button("-") { count -= 1 }
            TextBlock(count)
                .foregroundColor(count % 2 == 0 ? .green : .red)
                .border(Double(count))
                .background(count % 2 == 0 ? .red : .green)
                .border(Double(count))
                .background(count % 2 == 0 ? .green : .red)
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

struct Person: Identifiable {
    let id: Int
    let name: String
}

struct ForEachExample: Element {
    @State var people = [
        Person(id: 1, name: "Alice"),
        Person(id: 2, name: "Bob"),
        Person(id: 3, name: "John"),
    ]
    var content: some Element {
        StackPanel {
            ForEach(people) {
                TextBlock($0.name)
            }
            Button("Shuffle") {
                people.shuffle()
            }
            ForEach(1...5) {
                TextBlock($0)
            }
        }
    }
}

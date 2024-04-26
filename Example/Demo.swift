import Foundation
import Swui
import Observation

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
            SliderExample()
                .navigationItem("Slider", glyph: .sliderThumb)
            ImageExample()
                .navigationItem("Image", glyph: .picture)
        }
    }
}

@Observable class CounterViewModel {
    var count = 20
    func increment() {
        count += 1
    }
}

struct CounterExample: Element {
    @State var count = 20
    var state1 = CounterViewModel()
    var state2 = CounterViewModel()

    var content: some Element {
        StackPanel {
            ProgressRing()
            StackPanel {
                TextBlock("Outer state: \(state1.count)")
                NestedCounter()
            }
            .enviroment(state1)
            StackPanel {
                TextBlock("Outer state: \(state2.count)")
                NestedCounter()
            }
            .enviroment(state2)
        }
    }
}

struct NestedCounter: Element {
    @Enviroment(CounterViewModel.self) var state

    var content: some Element {
        StackPanel(.horizontal) {
            Button(state.count - 1) { state.count -= 1 }
            TextBlock(state.count)
            Button(state.count + 1) { state.increment() }
        }
    }
}

struct ToggleExample: Element {
    @State var isOn = true
    var content: some Element {
        StackPanel {
            ToggleSwitch($isOn)
            CounterExample()
            if isOn {
                TextBlock("I'm on!")
            } else {
                CounterExample()
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
            .horizontalAlignment(.center)
            ForEach(1 ... 5) {
                TextBlock($0)
            }
        }
        .horizontalAlignment(.stretch)
        .scrollable()
    }
}

struct SliderExample: Element {
    @State var value = 0.0
    var content: some Element {
        StackPanel {
            TextBlock("Value: \(value)")
            Slider($value)
                .minWidth(200)
        }
    }
}

struct ImageExample: Element {
    var content: some Element {
        StackPanel(.horizontal) {
            Image(Bundle.module.path(forResource: "swift", ofType: "svg")!)
                .width(200)
            Image("https://picsum.photos/200/300")
                .width(200)
        }.spacing(50)
    }
}

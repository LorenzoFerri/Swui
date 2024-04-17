import Foundation
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
            SliderExample()
                .navigationItem("Slider", glyph: .sliderThumb)
            ImageExample()
                .navigationItem("Image", glyph: .picture)
        }
    }
}

struct CounterExample: Element {
    @State var count = 20
    var content: some Element {
        StackPanel(.horizontal) {
            Button(count - 1) { count -= 1 }
            TextBlock(count)
                .margin(Double(count))
                .verticalAlignment(.center)
                .background(.red)
            Button(count + 1) { count += 1 }
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
            ForEach(1 ... 5) {
                TextBlock($0)
            }
        }.scrollable()
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

import WinUI

// struct OptionalView<Content: View>: UIViewRepresentable {
//     var body: Never { fatalError() }
//     var view: UIElement
//     var content: Content?
//     init(_ content: Content?) {
//         self.content = content
//         view = if let content {
//             content._makeView()
//         } else {
//             Frame()
//         }
//     }

//     func makeUIView() -> UIElement {
//         if content != nil {
//             view
//         } else {
//             Frame()
//         }
//     }

//     mutating func updateUIView() {
//         if let content {
//             view = content._makeView()
//         } else {
//             view = Frame()
//         }
//     }
// }
import WinUI


struct OptionalView<Content: View>: UIViewRepresentable {
    var body: Never { fatalError() }
    var content: Content?
    init(_ content: Content?) {
        self.content = content
    }
    func makeUIView() -> (some UIElement)? {
        content?._makeView()
    }

    func updateUIView(view: UIViewType) {
        
    }
}

// struct OptionalView<Content: View>: View {
//     var content: Content?
    
//     init(_ content: Content?) {
//         self.content = content
//     }
//     var body = {
//         if content != nil {
//             content
//         } else {
//             EmptyView()
//         }
//     }
// }
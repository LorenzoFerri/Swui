import Observation
import WinAppSDK
import WinSDK
import WinUI

struct StackPanel<each Content: View>: UIViewRepresentable {
    var body: Never { fatalError() }

    let content: (repeat each Content)
    let orientation: Orientation
    let verticalAlignment: VerticalAlignment
    let horizontalAlignment: HorizontalAlignment
    let spacing: Double

    init(
        orientation: Orientation = .vertical,
        verticalAlignment: VerticalAlignment = .center,
        horizontalAlignment: HorizontalAlignment = .center,
        spacing: Double = 20,
        @ViewBuilder content: () -> (repeat each Content)
    ) {
        self.content = content()
        self.orientation = orientation
        self.horizontalAlignment = horizontalAlignment
        self.verticalAlignment = verticalAlignment
        self.spacing = spacing
    }

    func makeUIView() -> WinUI.StackPanel? {
        let stackPanel = WinUI.StackPanel()
        for view in repeat each content {
            if let view = view._makeView() {
                stackPanel.children.append(view)
            }
        }
        updateUIView(view: stackPanel)
        return stackPanel
    }

    func updateUIView(view stackPanel: WinUI.StackPanel) {
        withObservationTracking {
            print((repeat each content))
            stackPanel.orientation = orientation
            stackPanel.verticalAlignment = verticalAlignment
            stackPanel.horizontalAlignment = horizontalAlignment
            stackPanel.spacing = spacing
        } onChange: {
            
            Task { @MainActor in
                self.updateUIView(view: stackPanel)
            }
        }
    }
}

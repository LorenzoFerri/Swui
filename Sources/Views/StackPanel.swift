import Foundation
import Observation
import WinUI

struct StackPanel<each Content: View>: Layout {
    var view: WinUI.StackPanel?
    var content: () -> (repeat each Content)
    let orientation: Orientation
    let verticalAlignment: VerticalAlignment
    let horizontalAlignment: HorizontalAlignment
    let spacing: Double
    var state = LayoutState()

    init(
        orientation: Orientation = .vertical,
        verticalAlignment: VerticalAlignment = .center,
        horizontalAlignment: HorizontalAlignment = .center,
        spacing: Double = 20,
        @ViewBuilder content: @escaping () -> (repeat each Content)
    ) {
        self.content = content
        self.orientation = orientation
        self.horizontalAlignment = horizontalAlignment
        self.verticalAlignment = verticalAlignment
        self.spacing = spacing
    }

    mutating func makeUIView() -> WinUI.StackPanel? {
        view = WinUI.StackPanel()
        makeLayout(content)
        updateUIView()
        return view
    }

    func updateUIView() {
        if let view {
            withObservationTracking {
                updateLayout(content)
                view.orientation = orientation
                view.verticalAlignment = verticalAlignment
                view.horizontalAlignment = horizontalAlignment
                view.spacing = spacing
            } onChange: {
                Task { @MainActor in
                    self.updateUIView()
                }
            }
        }
    }
}

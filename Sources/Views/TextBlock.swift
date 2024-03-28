import Dispatch
import Foundation
import Observation
import WinAppSDK
import WinUI

struct TextBlock<Value: LosslessStringConvertible>: UIViewRepresentable {
    var body: Never { fatalError() }

    var value: (() -> Value)
    let verticalAlignment: VerticalAlignment = .center
    let horizontalAlignment: HorizontalAlignment = .center

    init(_ value: @autoclosure @escaping () -> Value) {
        self.value = value
    }

    func makeUIView() -> WinUI.TextBlock? {
        let textBlock = WinUI.TextBlock()
        updateUIView(view: textBlock)
        return textBlock
    }

    func updateUIView(view textBlock: WinUI.TextBlock) {
        withObservationTracking {
            textBlock.text = value().description
            textBlock.verticalAlignment = verticalAlignment
            textBlock.horizontalAlignment = horizontalAlignment
        } onChange: {
            Task { @MainActor in
                self.updateUIView(view: textBlock)
            }
        }
    }
}

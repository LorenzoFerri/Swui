import Observation
import WinUI

public struct Slider: UIElementRepresentable {
    public var element: WinUI.Slider?
    @Binding var value: Double
    let minimum: () -> Double
    let maximum: () -> Double

    public init(
        _ value: Binding<Double>,
        minimum: @autoclosure @escaping () -> Double = 0.0,
        maximum: @autoclosure @escaping () -> Double = 100.0
    ) {
        _value = value
        self.minimum = minimum
        self.maximum = maximum
    }

    public mutating func makeUIElement(context: Context) -> WinUI.Slider? {
        element = WinUI.Slider()
        if let element {
            element.horizontalAlignment = .stretch
            element.valueChanged.addHandler { [self] _, _ in
                self.value = element.value
            }
        }
        updateUIElement(context: context)
        return element
    }

    public func updateUIElement(context: Context) {
        if let element {
            withObservationTracking {
                element.value = value
                element.minimum = minimum()
                element.maximum = maximum()
            } onChange: {
                Task { @MainActor in
                    self.updateUIElement(context: context)
                }
            }
        }
    }
}

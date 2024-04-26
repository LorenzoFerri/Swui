import Foundation
import Observation
import WinUI

public struct ProgressRing: UIElementRepresentable {
    public var element: WinUI.ProgressRing?

    public init() {}

    public mutating func makeUIElement(context: Context) -> WinUI.ProgressRing? {
        element = WinUI.ProgressRing()
        element?.isActive = true
        updateUIElement(context: context)
        return element
    }

    public func updateUIElement(context: Context) {}
}

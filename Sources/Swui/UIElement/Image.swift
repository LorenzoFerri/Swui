import Foundation
import Observation
import WindowsFoundation
import WinUI

private class BundleFinder {}


public struct Image: UIElementRepresentable {
    public var element: WinUI.Image?
    let source: () -> String
    var imageSource: BitmapImage?
    var svgSource: SvgImageSource?

    public init(_ source: @autoclosure @escaping () -> String) {
        self.source = source
    }

    public mutating func makeUIElement() -> WinUI.Image? {
        element = WinUI.Image()
        imageSource = BitmapImage()
        svgSource = SvgImageSource()
        updateUIElement()
        return element
    }

    public func updateUIElement() {
        if let element {
            withObservationTracking {
                let path = source()
                if path.hasSuffix(".svg") {
                    svgSource?.uriSource = Uri(path)
                    element.source = svgSource
                } else {
                    imageSource?.uriSource = Uri(path)
                    element.source = imageSource
                }
            } onChange: {
                Task { @MainActor in
                    self.updateUIElement()
                }
            }
        }
    }
}

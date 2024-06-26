import Foundation
import Observation
import WindowsFoundation
import WinUI

public struct Image: UIElementRepresentable {
    public var element: WinUI.Image?
    let source: () -> String
    var imageSource: BitmapImage?
    var svgSource: SvgImageSource?

    public init(_ source: @autoclosure @escaping () -> String) {
        self.source = source
    }

    public init(_ source: @autoclosure @escaping () -> Resource) {
        self.source = { source().path }
    }

    public mutating func makeUIElement(context: Context) -> WinUI.Image? {
        element = WinUI.Image()
        imageSource = BitmapImage()
        svgSource = SvgImageSource()
        updateUIElement(context: context)
        return element
    }

    public func updateUIElement(context: Context) {
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
                    self.updateUIElement(context: context)
                }
            }
        }
    }
}

import Foundation
import Observation
import UWP
import WinUI

struct StackPanel<Content: Group>: Panel {
    var element: WinUI.StackPanel?
    var content: () -> Content
    @State private var orientation: Orientation = .vertical
    @State private var verticalAlignment: VerticalAlignment = .center
    @State private var horizontalAlignment: HorizontalAlignment = .center
    @State private var spacing: Double = 20.0
    internal var state = PanelState()

    init(
        _ orientation: @escaping @autoclosure () -> Orientation = .vertical,
        @GroupBuilder content: @escaping () -> Content
    ) {
        self.content = content
        _ = self._orientation(orientation)
    }

    mutating func makeUIElement() -> WinUI.StackPanel? {
        element = WinUI.StackPanel()
        makePanel(content)
        updateUIElement()
        return element
    }

    func updateUIElement() {
        if let element {
            withObservationTracking {
                updatePanel(content)
                element.orientation = orientation
                element.verticalAlignment = verticalAlignment
                element.horizontalAlignment = horizontalAlignment
                element.spacing = spacing
            } onChange: {
                Task { @MainActor in
                    self.updateUIElement()
                }
            }
        }
    }
}

extension StackPanel {
    func orientation(_ orientation: @escaping @autoclosure () -> Orientation) -> Self {
        return _orientation(orientation)
    }

    private func _orientation(_ orientation: @escaping () -> Orientation) -> Self {
        withObservationTracking {
            self.orientation = orientation()
        } onChange: {
            Task { @MainActor in
                self._orientation(orientation)
            }
        }
        return self
    }

    func horizontalAlignment(_ horizontalAlignment: @escaping @autoclosure () -> HorizontalAlignment) -> Self {
        return _horizontalAlignment(horizontalAlignment)
    }

    private func _horizontalAlignment(_ horizontalAlignment: @escaping () -> HorizontalAlignment) -> Self {
        withObservationTracking {
            self.horizontalAlignment = horizontalAlignment()
        } onChange: {
            Task { @MainActor in
                self._horizontalAlignment(horizontalAlignment)
            }
        }
        return self
    }

    func verticalAlignment(_ verticalAlignment: @escaping @autoclosure () -> VerticalAlignment) -> Self {
        return _verticalAlignment(verticalAlignment)
    }

    private func _verticalAlignment(_ verticalAlignment: @escaping () -> VerticalAlignment) -> Self {
        withObservationTracking {
            self.verticalAlignment = verticalAlignment()
        } onChange: {
            Task { @MainActor in
                self._verticalAlignment(verticalAlignment)
            }
        }
        return self
    }

    func spacing(_ spacing: @escaping @autoclosure () -> Double) -> Self {
        return _spacing(spacing)
    }

    private func _spacing(_ spacing: @escaping () -> Double) -> Self {
        withObservationTracking {
            self.spacing = spacing()
        } onChange: {
            Task { @MainActor in
                self._spacing(spacing)
            }
        }
        return self
    }
}

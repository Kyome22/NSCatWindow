import AppKit

final class NSCatView: NSView {
    private let earOffset: CGFloat = 24
    private let toolbarHeight: CGFloat = 24
    private let tailRadius: CGFloat = 8
    private var mouseInside: Bool = false
    private var windowButtons: [NSButton] = []
    private var titleLabel = NSTextField(labelWithString: "")

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(childView: NSView) {
        super.init(frame: .zero)

        childView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(childView)
        childView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        childView.rightAnchor.constraint(equalTo: rightAnchor, constant: -2 * tailRadius).isActive = true
        var offset = earOffset + toolbarHeight
        childView.topAnchor.constraint(equalTo: topAnchor, constant: offset).isActive = true
        childView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -2 * tailRadius).isActive = true
        offset = earOffset + 0.5 * toolbarHeight
        titleLabel.centerYAnchor.constraint(equalTo: topAnchor, constant: offset).isActive = true
        titleLabel.font = NSFont.systemFont(ofSize: 11, weight: .bold)
        titleLabel.textColor = NSColor.secondaryLabelColor
    }

    override func draw(_ dirtyRect: NSRect) {
        let width = dirtyRect.width - 2
        let height = dirtyRect.height - 2
        let earRadius: CGFloat = 16 // 2 * earOffset / 3
        let cornerRadius: CGFloat = 8
        let earCornerRadius: CGFloat = 4
        let phi1: CGFloat = 7 / 6 * .pi
        let phi3: CGFloat = -1 / 6 * .pi
        let innerRadius = 2 * (earOffset - 2 * earCornerRadius) / 3
        let innerOffset = 2 * (earOffset + earCornerRadius) / 3

        let outlinePath = NSBezierPath()
        // bottom-left corner
        outlinePath.move(to: CGPoint(x: cornerRadius, y: 0))
        outlinePath.appendArc(withCenter: CGPoint(x: cornerRadius, y: cornerRadius),
                              radius: cornerRadius,
                              startAngle: 270,
                              endAngle: 180,
                              clockwise: true)
        // top-left corner
        outlinePath.appendArc(withCenter: CGPoint(x: cornerRadius, y: height - earOffset - cornerRadius),
                              radius: cornerRadius,
                              startAngle: 180,
                              endAngle: 90,
                              clockwise: true)
        // left ear
        let leftCenter = CGPoint(x: earOffset, y: height - earRadius)
        outlinePath.line(to: CGPoint(x: leftCenter.x + earRadius * cos(phi1),
                                     y: leftCenter.y + earRadius * sin(phi1)))
        outlinePath.appendArc(withCenter: CGPoint(x: leftCenter.x, y: height - 2 * earCornerRadius),
                              radius: earCornerRadius,
                              startAngle: 150,
                              endAngle: 30,
                              clockwise: true)
        outlinePath.line(to: CGPoint(x: leftCenter.x + earRadius * cos(phi3),
                                     y: leftCenter.y + earRadius * sin(phi3)))
        // right ear
        let rightCenter = CGPoint(x: width - earOffset - 2 * tailRadius, y: height - earRadius)
        outlinePath.line(to: CGPoint(x: rightCenter.x + earRadius * cos(phi1),
                                     y: rightCenter.y + earRadius * sin(phi1)))
        outlinePath.appendArc(withCenter: CGPoint(x: rightCenter.x, y: height - 2 * earCornerRadius),
                              radius: earCornerRadius,
                              startAngle: 150,
                              endAngle: 30,
                              clockwise: true)
        outlinePath.line(to: CGPoint(x: rightCenter.x + earRadius * cos(phi3),
                                     y: rightCenter.y + earRadius * sin(phi3)))
        // top-right corner
        outlinePath.appendArc(withCenter: CGPoint(x: width - cornerRadius - 2 * tailRadius, y: height - earOffset - cornerRadius),
                              radius: cornerRadius,
                              startAngle: 90,
                              endAngle: 0,
                              clockwise: true)
        // tail
        outlinePath.line(to: CGPoint(x: width - 2 * tailRadius,
                                     y: cornerRadius + tailRadius))
        outlinePath.appendArc(withCenter: CGPoint(x: width - 2 * tailRadius, y: cornerRadius + 2 * tailRadius),
                              radius: tailRadius,
                              startAngle: -90,
                              endAngle: 0,
                              clockwise: false)
        outlinePath.appendArc(withCenter: CGPoint(x: width - 0.5 * tailRadius, y: cornerRadius + 4 * tailRadius),
                              radius: 0.5 * tailRadius,
                              startAngle: 180,
                              endAngle: 0,
                              clockwise: true)
        outlinePath.appendArc(withCenter: CGPoint(x: width - 2 * tailRadius, y: cornerRadius + 2 * tailRadius),
                              radius: 2 * tailRadius,
                              startAngle: 0,
                              endAngle: -90,
                              clockwise: true)
        // bottom-right corner
        outlinePath.appendArc(withCenter: CGPoint(x: width - cornerRadius - 2 * tailRadius, y: cornerRadius),
                              radius: cornerRadius,
                              startAngle: 0,
                              endAngle: -90,
                              clockwise: true)
        outlinePath.close()
        outlinePath.transform(using: AffineTransform(translationByX: 1, byY: 1))
        NSColor.windowBackgroundColor.setFill()
        outlinePath.fill()
        NSColor.tertiaryLabelColor.setStroke()
        outlinePath.lineWidth = effectiveAppearance.isDark ? 1.0 : 0.5
        outlinePath.stroke()

        let earPath = NSBezierPath()
        // left inner ear
        let leftInnerCenter = CGPoint(x: earOffset, y: height - innerOffset)
        earPath.move(to: CGPoint(x: leftInnerCenter.x + innerRadius * cos(phi1),
                                 y: leftInnerCenter.y + innerRadius * sin(phi1)))
        earPath.appendArc(withCenter: CGPoint(x: leftInnerCenter.x, y: height - 3 * earCornerRadius),
                          radius: 0.5 * earCornerRadius,
                          startAngle: 150,
                          endAngle: 30,
                          clockwise: true)
        earPath.line(to: CGPoint(x: leftInnerCenter.x + innerRadius * cos(phi3),
                                 y: leftInnerCenter.y + innerRadius * sin(phi3)))
        earPath.close()
        // right inner ear
        let rightInnerCenter = CGPoint(x: width - earOffset - 2 * tailRadius, y: height - innerOffset)
        earPath.move(to: CGPoint(x: rightInnerCenter.x + innerRadius * cos(phi1),
                                 y: rightInnerCenter.y + innerRadius * sin(phi1)))
        earPath.appendArc(withCenter: CGPoint(x: rightInnerCenter.x, y: height - 3 * earCornerRadius),
                          radius: 0.5 * earCornerRadius,
                          startAngle: 150,
                          endAngle: 30,
                          clockwise: true)
        earPath.line(to: CGPoint(x: rightInnerCenter.x + innerRadius * cos(phi3),
                                 y: rightInnerCenter.y + innerRadius * sin(phi3)))
        earPath.close()
        earPath.transform(using: AffineTransform(translationByX: 1, byY: 1))
        NSColor.tertiaryLabelColor.setFill()
        earPath.fill()
    }

    @objc func _mouseInGroup(_ button: NSButton) -> Bool {
        return mouseInside
    }

    private func setNeedsDisplayToWindowButtons() {
        windowButtons.forEach { button in
            button.needsDisplay = true
        }
    }

    override func mouseEntered(with event: NSEvent) {
        super.mouseEntered(with: event)
        mouseInside = true
        setNeedsDisplayToWindowButtons()
    }

    override func mouseExited(with event: NSEvent) {
        super.mouseExited(with: event)
        mouseInside = false
        setNeedsDisplayToWindowButtons()
    }

    func setTitle(_ title: String) {
        titleLabel.stringValue = title
    }

    func setWindowButton(_ button: NSButton?) {
        guard let button, !subviews.contains(button) else { return }
        button.removeFromSuperview()
        button.translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)
        button.leftAnchor.constraint(equalTo: leftAnchor, constant: button.frame.minX).isActive = true
        let offset = earOffset + 0.5 * toolbarHeight
        button.centerYAnchor.constraint(equalTo: topAnchor, constant: offset).isActive = true

        let trackingArea = NSTrackingArea(
            rect: button.bounds,
            options: [.mouseEnteredAndExited, .activeAlways, .inVisibleRect],
            owner: self
        )
        button.addTrackingArea(trackingArea)
        windowButtons.append(button)
    }
}

extension NSAppearance {
    var isDark: Bool {
        if self.name == .vibrantDark { return true }
        return self.bestMatch(from: [.aqua, .darkAqua]) == .darkAqua
    }
}

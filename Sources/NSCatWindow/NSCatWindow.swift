import AppKit
import SwiftUI

open class NSCatWindow: NSWindow {
    public init() {
        super.init(
            contentRect: .zero,
            styleMask: [.closable, .miniaturizable, .resizable, .fullSizeContentView, .titled],
            backing: .buffered,
            defer: false
        )
        isMovableByWindowBackground = true
        titlebarAppearsTransparent = true
        backgroundColor = .clear
        isOpaque = false
        hasShadow = true
    }

    public func setChildView(_ childView: NSView) {
        contentView = NSCatView(childView: childView)
    }

    public func setTitle(_ title: String) {
        (contentView as? NSCatView)?.setTitle(title)
    }

    override public var canBecomeKey: Bool { true }

    override public var canBecomeMain: Bool { true }

    override public func updateConstraintsIfNeeded() {
        super.updateConstraintsIfNeeded()
        if let catView = contentView as? NSCatView, catView.subviews.count == 2 {
            catView.setWindowButton(standardWindowButton(.closeButton))
            catView.setWindowButton(standardWindowButton(.miniaturizeButton))
            catView.setWindowButton(standardWindowButton(.zoomButton))
        }
    }
}

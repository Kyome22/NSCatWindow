import AppKit
import SwiftUI

open class NSCatWindow: NSWindow {
    public init(childView: NSView? = nil) {
        super.init(
            contentRect: .zero,
            styleMask: [.closable, .miniaturizable, .resizable, .fullSizeContentView, .titled],
            backing: .buffered,
            defer: false
        )
        isReleasedWhenClosed = false
        isMovableByWindowBackground = true
        titlebarAppearsTransparent = true
        backgroundColor = .clear
        isOpaque = false
        hasShadow = true
        if let childView {
            contentView = NSCatView(childView: childView)
        }
    }

    public func setChildView(_ childView: NSView) {
        contentView = NSCatView(childView: childView)
    }

    override public var canBecomeKey: Bool { true }

    override public var canBecomeMain: Bool { true }

    override public func updateConstraintsIfNeeded() {
        super.updateConstraintsIfNeeded()
        if let catView = contentView as? NSCatView, catView.subviews.count == 1 {
            catView.setWindowButton(standardWindowButton(.closeButton))
            catView.setWindowButton(standardWindowButton(.miniaturizeButton))
            catView.setWindowButton(standardWindowButton(.zoomButton))
        }
    }
}

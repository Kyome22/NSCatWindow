//
//  AppDelegate.swift
//  Example
//
//  Created by Takuto Nakamura on 2024/03/27.
//

import Cocoa
import SwiftUI
import NSCatWindow

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    var catWindow: NSCatWindow?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let hostingView = NSHostingView(rootView: SampleView())
        catWindow = NSCatWindow(childView: hostingView)
        catWindow?.setTitle("Sample")
        catWindow?.center()
        catWindow?.orderFront(nil)
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool { true }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool { true }
}

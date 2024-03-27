# NSCatWindow

<!-- # Short Description -->

Provides NSWindow with cat ears and tail

<!-- # Badges -->

[![Github issues](https://img.shields.io/github/issues/Kyome22/NSCatWindow)](https://github.com/Kyome22/NSCatWindow/issues)
[![Github forks](https://img.shields.io/github/forks/Kyome22/NSCatWindow)](https://github.com/Kyome22/NSCatWindow/network/members)
[![Github stars](https://img.shields.io/github/stars/Kyome22/NSCatWindow)](https://github.com/Kyome22/NSCatWindow/stargazers)
[![Github top language](https://img.shields.io/github/languages/top/Kyome22/NSCatWindow)](https://github.com/Kyome22/NSCatWindow/)
[![Github license](https://img.shields.io/github/license/Kyome22/NSCatWindow)](https://github.com/Kyome22/NSCatWindow/)

# Tags

`Swift` `AppKit`

# Demo

<img src="screenshots/file-4-0.png" width="300px" alt="demo" />

# Minimal Example

```swift
let hostingView = NSHostingView(rootView: SomeSwiftUIView())
hostingView.setFrameSize(hostingView.fittingSize)
let catWindow = NSCatWindow(childView: hostingView)
catWindow.makeKeyAndOrderFront(nil)
```

# Contributors

- [Kyome22](https://github.com/Kyome22)

<!-- CREATED_BY_LEADYOU_README_GENERATOR -->

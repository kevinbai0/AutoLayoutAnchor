# AutoLayoutAnchor
Add a subview and its constraints in just one line of code. Reduces verbosity of NSLayoutAnchors while maintaining readability.

Example of usage:
```swift
let view1 = UIView()
view1.addToView(self.view, .left([10]), .right([-5, Anchor.centerX]), .top([28]), .bottom([Anchor.centerY, -10]))
```

or 

```swift
view1.addToView(self.view, 
  .left([10]), 
  .right([-5, Anchor.centerX]), 
  .top([28]), 
  .bottom([Anchor.centerY, -10])
)
```
These two lines of code create a UIView, adds it to the view, and creates the constraints

AutoLayoutAnchor is created in just one file and is an extension of UIView. To add to your project, simply clone the repository and drag the AutoLayoutAnchor.swift file and include it into your own XCode Project.

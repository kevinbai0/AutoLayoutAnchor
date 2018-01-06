# AutoLayoutAnchor
Add a subview and its constraints in just one line of code. Reduces verbosity of NSLayoutAnchors while maintaining readability.

## Example of usage:
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

## Installation
AutoLayoutAnchor is created in just one file and is an extension of UIView. To add to your project, simply clone the repository and drag the AutoLayoutAnchor.swift file and include it into your own XCode Project.

## Usage

### Main Extensions of UIView
```swift
addToView(_ view: UIView, _ anchors: AutoLayoutAnchor...)
```
and
```swift
setConstraints(to view: UIView? = nil, _anchors: AutoLayoutAnchor...)
```
Both functions set `translatesAutoresizingMaskIntoConstraints = false`. The `addToView` function additionally adds the view as a subview to a specified view.

### AutoLayoutAnchor

AutoLayoutAnchor is an enum with associated values of `[Any]`. 

```swift
enum AutoLayoutAnchor {
  case leading([Any]), trailing([Any]), left([Any]), centerX([Any]), right([Any]), top([Any]), firstB([Any]), centerY([Any]),   lastB([Any]), bottom([Any]), width([Any]), height([Any])
  static func createConstraint(firstAnchor: Anchor, originalAnchor: (NSLayoutXAxisAnchor?, NSLayoutYAxisAnchor?, NSLayoutDimension?), originalView: UIView?, array: [Any]) -> NSLayoutConstraint?
```

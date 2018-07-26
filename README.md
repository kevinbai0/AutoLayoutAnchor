# AutoLayoutAnchor
Add a subview and its constraints in just one line of code. Reduces verbosity of NSLayoutAnchors while maintaining readability.

Example of a login page created using ALLayout:

![alt text](https://i.imgur.com/p9RyyHz.png?4)

Only 5 lines of code are needed to set the constraints:
```swift
userTextField.addToView(self, .centerX, .width(0.8.ratio), .top(self.centerY), .height(0.08.ratio))
passTextField.addToView(self, .centerX, .width(0.8.ratio), .top(userTextField.bottom, 10.pad), .height(0.08.ratio))
loginBtn.addToView(self, .centerX, .width(0.8.ratio), .top(passTextField.bottom, 10.pad), .height(0.08.ratio))
forgotPasswordButton.addToView(self, .top(30.pad, loginBtn.bottom), .centerX, .width(0.6.ratio), .height(30.constant))
createAccountButton.addToView(self, .bottom(20.pad), .centerX, .height(30.constant), .width(0.6.ratio))
```

## Example of usage:
```swift
let view1 = UIView()
view1.addToView(self.view, .left(10.pad), .right(5.pad, self.centerX), .top(28.pad), .bottom(self.centerY, 10.pad))
```

or 

```swift
view1.addToView(self.view, //adds view1 to self.view
  .left(10.pad), //view1's left anchor is 10 points to the right of self.view's left anchor
  .right(5.pad, self.centerX), //view1's right anchor is 5 points to the left of self.view's centerX anchor
  .top(28.pad), //view1's top anchor is 28 points below of self.view's top anchor
  .bottom(self.centerY, 10.pad) //view1's bottom anchor is 10 points above self.view's centerY anchor
)
```
These two lines of code create a UIView, adds it to the view, and creates the constraints

## Installation
ALLayout is created to extend UIView. To add to your project, simply clone the repository and drag the files in src to your own XCode Project. A CocoaPod will be created in the future

## General Usage
### Main
The rules of NSLayoutAnchors, NSLayoutConstraints, and Auto Layout apply the exactly same. Background with Auto Layout helps to create constraints with AutoLayoutAnchor. This library simply wraps the NSLayoutAnchor into a less-verbose package


Always use `addToView()` or `setConstraints()` to when setting constraints.
```swift
addToView(_ view: UIView, _ anchors: AutoLayoutAnchor...)
```
and
```swift
setConstraints(to view: UIView? = nil, _anchors: AutoLayoutAnchor...)
```
Both functions set `translatesAutoresizingMaskIntoConstraints = false`. The `addToView` function additionally adds the view as a subview to a specified view.

Example - say `view1` is the subview and it is being added to `self.view`:
```swift
view1.addToView(self.view, //add all anchors (unless specified) to self.view
  .left()
  .right()
  .top()
  .bottom()
)
```

Once constraints are set, the constraint manager manages all the constraints added by the ALLayoutLibrary. This helps for easy access of constraints of a view while giving the ability to change the constraints easily.
Each UIView object has 6 properties: 
```swift
    var x1Anchor: ALAnchor?
    var x2Anchor: ALAnchor?
    var widthALAnchor: ALAnchor?
    var y1Anchor: ALAnchor?
    var y2Anchor: ALAnchor?
    var heightALAnchor: ALAnchor?
```
    
## Easier animations with ALLayout
After constraints are set, a view has up to 4 constraints. There will always be at least one x-axis and y-axis constraint. For elements such as labels, only 2 constraints are needed, but for some elements, a second x/y - axis constraint may be needed or width/height constraints are needed. This is where the constraint manager comes in handy. You can set x,y, width and height constraints simply by setting the value of the 6 properties defined above.

For example: ```view.x1Anchor = .left //.left is a static initializer of the ALAnchor class and this simply means to set the left anchor of the view to the left anchor of it's superview (since no new anchor is specified and no other properties are specified```

Doing this, we can simply change a constraint by doing: 
```swift 
    view.x1Anchor = .left(10.pad) // this sets the left anchor of the view to be 10 pixels to the right of it's superview's left anchor
    UIView.animate(withDuration: 0.2) {
        self.layoutIfNeeded() // this updates the view and animates a view 
    }
}
```

## Detailed Usage
### ALAnchor

ALAnchor is the class that represents a constraint. It contains all the properties of the constraint, and defines the methods to convert an ALAnchor to NSLayoutConstraint.

### AnchorProperty

Each property defined to create a constraint must be a AnchorProperty.
An ALProperty can represent an AnchorType, CGFloat (as constants), CGFloat (as multipliers), or a UIView and AnchorType.

### AnchorType

An AnchorType is simply an enum that represents different anchors of a view.

### AnchorDimension

This enum is used by ALProperty and AnchorLayout in order to determine whether an AnchorType is an x-axis constraint, y-axis constraint, or width/height constraint.


## More Documentation to Follow


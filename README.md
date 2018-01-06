# AutoLayoutAnchor
Add a subview and its constraints in just one line of code. Reduces verbosity of NSLayoutAnchors while maintaining readability.

Example of a login page created using AutoAnchorLayouts:
![alt text](https://i.imgur.com/p9RyyHz.png)

Only 5 lines of code are needed to set the constraints:
```swift
userTextField.addToView(self, .centerX([]), .width([0,0.8]), .top([Anchor.centerY]), .height([0, 0.08]))
passTextField.addToView(self, .centerX([]), .width([0,0.8]), .top([userTextField, Anchor.bottom, 10]), .height([0, 0.08]))
loginBtn.addToView(self, .centerX([]), .width([0,0.8]), .top([passTextField, Anchor.bottom, 10]), .height([0, 0.08]))
forgotPasswordButton.addToView(self, .top([30, loginBtn, Anchor.bottom]), .centerX([]), .width([0, 0.6]), .height([30]))
createAccountButton.addToView(self, .bottom([-20]), .centerX([]), .height([30]), .width([0, 0.6]))
```

## Example of usage:
```swift
let view1 = UIView()
view1.addToView(self.view, .left([10]), .right([-5, Anchor.centerX]), .top([28]), .bottom([Anchor.centerY, -10]))
```

or 

```swift
view1.addToView(self.view, //adds view1 to self.view
  .left([10]), //view1's left anchor is 10 points to the right of self.view's left anchor
  .right([-5, Anchor.centerX]), //view1's right anchor is 5 points to the left of self.view's centerX anchor
  .top([28]), //view1's top anchor is 28 points below of self.view's top anchor
  .bottom([Anchor.centerY, -10]) //view1's bottom anchor is 10 points above self.view's centerY anchor
)
```
These two lines of code create a UIView, adds it to the view, and creates the constraints

## Installation
AutoLayoutAnchor is created in just one file and is an extension of UIView. To add to your project, simply clone the repository and drag the AutoLayoutAnchor.swift file and include it into your own XCode Project.

## General Usage
### Rules and Guidelines
The rules of NSLayoutAnchors, NSLayoutConstraints, and Auto Layout apply the exactly same. Background with Auto Layout helps to create constraints with AutoLayoutAnchor.

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
view1.addToView(self.view, //add to self.view
```
`self.view` also becomes the default view to add constraints to.
```swift
  .left([])
  .right([])
  .top([])
  .bottom([])
)
```

To be completed...

## Detailed Usage
### AutoLayoutAnchor
AutoLayoutAnchor is an enum with associated values of `[Any]`. 

```swift
enum AutoLayoutAnchor {
  case leading([Any]), trailing([Any]), left([Any]), centerX([Any]), right([Any]), top([Any]), 
  firstB([Any]), centerY([Any]),   lastB([Any]), bottom([Any]), width([Any]), height([Any])
}
```

Each of the cases of the `AutoLayoutAnchor` represents an NSLayoutDimension. The properties of the anchor can be manipulated through by passing values through the `[Any]` array.

Currently, the supported values are:
1. `CGFloat`, `Int`, `Double`, `Float` for constant and multiplier properties
2. `UIView` to set the specified view in which to set the anchor
3. `Anchor` (another enum) to set the specified view's anchor type

Although anything may be passed into the array, only the data types shown above are manipulated. Values can be passed into the array in any order but only 2 Number types (`CGFloat`, `Int`, `Float`, and `Double`) will be processed. The first number that is passed through is set as the constant. The second number passed through is set as the multiplier.

*If you only want to pass a multiplier through, pass the value 0 (to set the constant to 0) before the multiplier value. Ex: `AutoLayoutAnchor.width([0, 0.5])`.*

# To Be Completed

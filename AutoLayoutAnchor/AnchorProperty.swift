//
//  AnchorProperties.swift
//  AutoLayoutAnchor
//
//  Created by Kevin Bai on 2018-05-21.
//  Copyright © 2018 Kevin Bai. All rights reserved.
//

import UIKit

enum AnchorPropertyType {
    // constant is only used to define a fixed height or width, padding is for x and y
    case constant(CGFloat), padding(CGFloat), ratio(CGFloat), anchorType(AnchorType), view(UIView), viewAndAnchor(UIView, AnchorType) /* This one is an extension of uiview where you can call view.left for a anchor property that constrains to a view's left axis*/
}

struct AnchorProperty {
    var anchorPropertyType: AnchorPropertyType
    
    static var leading: AnchorProperty {
        get { return AnchorProperty(propertyType: .anchorType(.leading)) }
    }
    static var trailing: AnchorProperty {
        get { return AnchorProperty(propertyType: .anchorType(.trailing)) }
    }
    static var left: AnchorProperty {
        get { return AnchorProperty(propertyType: .anchorType(.left)) }
    }
    static var centerX: AnchorProperty {
        get { return AnchorProperty(propertyType: .anchorType(.centerX)) }
    }
    static var right: AnchorProperty {
        get { return AnchorProperty(propertyType: .anchorType(.right)) }
    }
    
    static var top: AnchorProperty {
        get { return AnchorProperty(propertyType: .anchorType(.top)) }
    }
    
    static var firstB: AnchorProperty {
        get { return AnchorProperty(propertyType: .anchorType(.firstB)) }
    }
    static var centerY: AnchorProperty {
        get { return AnchorProperty(propertyType: .anchorType(.centerY)) }
    }
    static var lastB: AnchorProperty {
        get { return AnchorProperty(propertyType: .anchorType(.lastB)) }
    }
    static var bottom: AnchorProperty {
        get { return AnchorProperty(propertyType: .anchorType(.bottom)) }
    }

    static var width: AnchorProperty {
        get { return AnchorProperty(propertyType: .anchorType(.width)) }
    }

    static var height: AnchorProperty {
        get { return AnchorProperty(propertyType: .anchorType(.height)) }
    }

    static func padding(_ value: CGFloat) -> AnchorProperty  {
        return AnchorProperty(propertyType: .padding(value))
    }
    static func multiplier(_ value: CGFloat) -> AnchorProperty  {
        return AnchorProperty(propertyType: .ratio(value))
    }

    init(propertyType: AnchorPropertyType) {
        self.anchorPropertyType = propertyType
    }
}

extension UIView {
    var leading: AnchorProperty {
        get { return AnchorProperty(propertyType: .viewAndAnchor(self, .leading))}
    }
    var trailing: AnchorProperty {
        get { return AnchorProperty(propertyType: .viewAndAnchor(self, .trailing))}
    }
    var left: AnchorProperty {
        get { return AnchorProperty(propertyType: .viewAndAnchor(self, .left))}
    }
    var centerX: AnchorProperty {
        get { return AnchorProperty(propertyType: .viewAndAnchor(self, .centerX))}
    }
    var right: AnchorProperty {
        get { return AnchorProperty(propertyType: .viewAndAnchor(self, .right))}
    }
    var top: AnchorProperty {
        get { return AnchorProperty(propertyType: .viewAndAnchor(self, .top))}
    }
    var firstB: AnchorProperty {
        get { return AnchorProperty(propertyType: .viewAndAnchor(self, .firstB))}
    }
    var centerY: AnchorProperty {
        get { return AnchorProperty(propertyType: .viewAndAnchor(self, .centerY))}
    }
    var lastB: AnchorProperty {
        get { return AnchorProperty(propertyType: .viewAndAnchor(self, .lastB))}
    }
    var bottom: AnchorProperty {
        get { return AnchorProperty(propertyType: .viewAndAnchor(self, .bottom))}
    }
    var width: AnchorProperty {
        get { return AnchorProperty(propertyType: .viewAndAnchor(self, .width))}
    }
    var height: AnchorProperty {
        get { return AnchorProperty(propertyType: .viewAndAnchor(self, .height))}
    }
}

extension CGFloat {
    var ratio: AnchorProperty {
        get {
            return AnchorProperty(propertyType: .ratio(self))
        }
    }
    var pad: AnchorProperty {
        get {
            return AnchorProperty(propertyType: .padding(self))
        }
    }
    var constant: AnchorProperty {
        get {
            return AnchorProperty(propertyType: .constant(self))
        }
    }
}

extension Double {
    var ratio: AnchorProperty {
        get {
            return AnchorProperty(propertyType: .ratio(CGFloat(self)))
        }
    }
    var pad: AnchorProperty {
        get {
            return AnchorProperty(propertyType: .padding(CGFloat(self)))
        }
    }
    var constant: AnchorProperty {
        get {
            return AnchorProperty(propertyType: .constant(CGFloat(self)))
        }
    }
}

extension Int {
    var ratio: AnchorProperty {
        get {
            return AnchorProperty(propertyType: .ratio(CGFloat(self)))
        }
    }
    var pad: AnchorProperty {
        get {
            return AnchorProperty(propertyType: .padding(CGFloat(self)))
        }
    }
    var constant: AnchorProperty {
        get {
            return AnchorProperty(propertyType: .constant(CGFloat(self)))
        }
    }
}

//
//  ALAnchorInitializers.swift
//  AutoLayoutAnchor
//
//  Created by Kevin Bai on 2018-05-21.
//  Copyright © 2018 Kevin Bai. All rights reserved.
//

import Foundation

extension ALAnchor {
    
    class var leading: ALAnchor {
        get { return ALAnchor(firstAnchorType: .leading, properties: []) }
    }
    class var trailing: ALAnchor {
        get { return ALAnchor(firstAnchorType: .trailing, properties: []) }
    }
    class var left: ALAnchor {
        get { return ALAnchor(firstAnchorType: .left, properties: []) }
    }
    class var centerX: ALAnchor {
        get { return ALAnchor(firstAnchorType: .centerX, properties: []) }
    }
    class var right: ALAnchor {
        get { return ALAnchor(firstAnchorType: .right, properties: []) }
    }
    class var top: ALAnchor {
        get { return ALAnchor(firstAnchorType: .top, properties: []) }
    }
    class var firstB: ALAnchor {
        get { return ALAnchor(firstAnchorType: .firstB, properties: []) }
    }
    class var centerY: ALAnchor {
        get { return ALAnchor(firstAnchorType: .centerY, properties: []) }
    }
    class var lastB: ALAnchor {
        get { return ALAnchor(firstAnchorType: .lastB, properties: []) }
    }
    class var bottom: ALAnchor {
        get { return ALAnchor(firstAnchorType: .bottom, properties: []) }
    }
    class var width: ALAnchor {
        get { return ALAnchor(firstAnchorType: .width, properties: []) }
    }
    class var height: ALAnchor {
        get { return ALAnchor(firstAnchorType: .height, properties: []) }
    }
    
    class func leading(_ properties: AnchorProperty...) -> ALAnchor {
        return ALAnchor(firstAnchorType: .leading, properties: properties)
    }
    class func trailing(_ properties: AnchorProperty...) -> ALAnchor {
        return ALAnchor(firstAnchorType: .trailing, properties: properties)
    }
    class func left(_ properties: AnchorProperty...) -> ALAnchor {
        return ALAnchor(firstAnchorType: .left, properties: properties)
    }
    class func centerX(_ properties: AnchorProperty...) -> ALAnchor {
        return ALAnchor(firstAnchorType: .centerX, properties: properties)
    }
    class func right(_ properties: AnchorProperty...) -> ALAnchor {
        return ALAnchor(firstAnchorType: .right, properties: properties)
    }
    class func top(_ properties: AnchorProperty...) -> ALAnchor {
        return ALAnchor(firstAnchorType: .top, properties: properties)
    }
    class func firstB(_ properties: AnchorProperty...) -> ALAnchor {
        return ALAnchor(firstAnchorType: .firstB, properties: properties)
    }
    class func centerY(_ properties: AnchorProperty...) -> ALAnchor {
        return ALAnchor(firstAnchorType: .centerY, properties: properties)
    }
    class func lastB(_ properties: AnchorProperty...) -> ALAnchor {
        return ALAnchor(firstAnchorType: .lastB, properties: properties)
    }
    class func bottom(_ properties: AnchorProperty...) -> ALAnchor {
        return ALAnchor(firstAnchorType: .bottom, properties: properties)
    }
    class func width(_ properties: AnchorProperty...) -> ALAnchor {
        return ALAnchor(firstAnchorType: .width, properties: properties)
    }
    class func height(_ properties: AnchorProperty...) -> ALAnchor {
        return ALAnchor(firstAnchorType: .height, properties: properties)
    }
}

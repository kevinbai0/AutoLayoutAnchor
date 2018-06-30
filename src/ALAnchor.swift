//
//  ALAnchor.swift
//  AutoLayoutAnchor
//
//  Created by Kevin Bai on 2018-05-21.
//  Copyright © 2018 Kevin Bai. All rights reserved.
//

import UIKit

class ALAnchor {
    var anchorView: UIView?
    var firstAnchorType: AnchorType
    var secondView: UIView?
    var secondAnchorType: AnchorType?
    
    var multiplier: CGFloat = 1.0
    var padding: CGFloat = 0.0
    var constant: CGFloat = 0.0
    var isConstantSet: Bool = false
    
    var properties: [AnchorProperty] {
        get { return [] }
        set {
            for property in newValue {
                switch property.anchorPropertyType {
                case .anchorType(let type):
                    self.secondAnchorType = type
                    break
                case .constant(let value):
                    if self.firstAnchorType.dimension == .size {
                        self.constant = value
                        self.isConstantSet = true
                    }
                    break
                case .padding(let value):
                    // if it's a left, top, width, height constraint, then the value will be positive
                    if self.firstAnchorType.hasNaturallyPositiveConstants {
                        constant = value
                    }
                    else {
                        // if it's a right, bottom, constraint, then the value will be a negative padding
                        constant = -value
                    }
                    break
                case .ratio(let value):
                    multiplier = value
                    break
                case .view(let value):
                    secondView = value
                    break
                case .viewAndAnchor(let view, let anchor):
                    secondView = view
                        self.secondAnchorType = anchor
                    secondAnchorType = anchor
                    break
                }
            }
        }
    }
    
    init(view: UIView? = nil, firstAnchorType: AnchorType, properties: [AnchorProperty]) {
        self.anchorView = view // if nil, then the constraint was probably called from view.addToView(UIView, anchors), in which this anchorView will be set after initialization
        self.firstAnchorType = firstAnchorType
        self.properties = properties
    }
    
    var dimAnchor: NSLayoutDimension? {
        if firstAnchorType.dimension == .size {
            if firstAnchorType == .width {
                return anchorView?.widthAnchor
            }
            else if firstAnchorType == .height {
                return anchorView?.heightAnchor
            }
        }
        return nil
    }
    
    static func createConstraint(anchor: ALAnchor) -> NSLayoutConstraint? {
        // if there is no first anchor view, then a constraint can't be made
        guard let firstAnchorView = anchor.anchorView else {
            return nil
        }
        guard let secondAnchorView = anchor.secondView else {
            // no view is specified then it must be a width or height constraint
            if anchor.firstAnchorType.dimension == .size {
                anchor.anchorView?.dimensionLayoutAnchor(anchorType: anchor.firstAnchorType)?.constraint(equalToConstant: anchor.constant)
            }
            return nil
        }
        var secondAnchorType = anchor.firstAnchorType // default
        if let second = anchor.secondAnchorType {
            secondAnchorType = second
        }
        
        if anchor.firstAnchorType.dimension == .x && secondAnchorType.dimension == .x {
            guard let secondAnchor = secondAnchorView.xLayoutAnchor(anchorType: secondAnchorType) else { return nil }
            return firstAnchorView.xLayoutAnchor(anchorType: anchor.firstAnchorType)?.constraint(equalTo: secondAnchor, constant: anchor.constant)
        }
        else if anchor.firstAnchorType.dimension == .y && secondAnchorType.dimension == .y {
            guard let secondAnchor = secondAnchorView.yLayoutAnchor(anchorType: secondAnchorType) else { return nil }
            return firstAnchorView.yLayoutAnchor(anchorType: anchor.firstAnchorType)?.constraint(equalTo: secondAnchor, constant: anchor.constant)
        }
        else if anchor.firstAnchorType.dimension == .size && secondAnchorType.dimension == .size {
            guard let secondAnchor = secondAnchorView.dimensionLayoutAnchor(anchorType: secondAnchorType) else { return nil }
            if anchor.isConstantSet {
                return firstAnchorView.dimensionLayoutAnchor(anchorType: anchor.firstAnchorType)?.constraint(equalToConstant: anchor.constant)
            }
            return firstAnchorView.dimensionLayoutAnchor(anchorType: anchor.firstAnchorType)?.constraint(equalTo: secondAnchor, multiplier: anchor.multiplier, constant: anchor.constant)
        }
        return nil
    }
    
}

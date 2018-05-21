//
//  ConstraintAnchors.swift
//  TiltDrop
//
//  Created by Kevin Bai on 2017-08-05.
//  Copyright © 2017 Kevin Bai. All rights reserved.

import Foundation
import UIKit

extension UIView {
    //add to subview and add constraints
    func addToView(_ view: UIView, _ anchors: AutoAnchor...) {
        view.addSubview(self)
        self.addConstraints(to: view, anchors: anchors)
    }
    
    //set constraints
    func setConstraints(to view: UIView? = nil,_ anchors: AutoAnchor...) {
        addConstraints(to: view, anchors: anchors)
    }
    
    //function to add constraints
    private func addConstraints(to view: UIView? = nil, anchors: [AutoAnchor]) {
        self.translatesAutoresizingMaskIntoConstraints = false
        for anchor in anchors {
            let _ = constraintFrom(anchor: anchor, to: view)
        }
    }
    
    func constraintFrom(anchor: AutoAnchor, to view: UIView? = nil) -> NSLayoutConstraint? {
        var view = view
        if let _ = view {
            //do nothing
        }
        else if let supView = self.superview {
            view = supView
        }
        let createdConstraint = AutoAnchor.createConstraint(firstAnchor: anchor, secondAnchor: anchor.firstAnchorType.getAnchor(view: self), originalView: view)
        createdConstraint?.isActive = true
        
        return createdConstraint
    }
}

enum Anchor {
    case leading, left, centerX, right, trailing, top, firstB, centerY, lastB, bottom, width, height
    
    func getAnchor(view: UIView) -> (NSLayoutXAxisAnchor?, NSLayoutYAxisAnchor?, NSLayoutDimension?) {
        switch self {
        case .leading:
            return (view.leadingAnchor, nil, nil)
        case .trailing:
            return (view.trailingAnchor, nil, nil)
        case .left:
            return (view.leftAnchor, nil, nil)
        case .right:
            return (view.rightAnchor, nil, nil)
        case .centerX:
            return (view.centerXAnchor, nil, nil)
        case .top:
            return (nil, view.topAnchor, nil)
        case .bottom:
            return (nil, view.bottomAnchor, nil)
        case .centerY:
            return (nil, view.centerYAnchor, nil)
        case .firstB:
            return (nil, view.firstBaselineAnchor, nil)
        case .lastB:
            return (nil, view.lastBaselineAnchor, nil)
        case .width:
            return (nil, nil, view.widthAnchor)
        case .height:
            return (nil, nil, view.heightAnchor)
        }
    }
}
class AutoAnchor {
    var firstAnchorType: Anchor
    var content: [Any]
    
    class func leading(_ content: Any...) -> AutoAnchor {
        return AutoAnchor(firstAnchorType: .leading, content: content)
    }
    class func trailing(_ content: Any...) -> AutoAnchor {
        return AutoAnchor(firstAnchorType: .trailing, content: content)
    }
    class func left(_ content: Any...) -> AutoAnchor {
        return AutoAnchor(firstAnchorType: .left, content: content)
    }
    class func centerX(_ content: Any...) -> AutoAnchor {
        return AutoAnchor(firstAnchorType: .centerX, content: content)
    }
    class func right(_ content: Any...) -> AutoAnchor {
        return AutoAnchor(firstAnchorType: .right, content: content)
    }
    class func top(_ content: Any...) -> AutoAnchor {
        return AutoAnchor(firstAnchorType: .top, content: content)
    }
    class func firstB(_ content: Any...) -> AutoAnchor {
        return AutoAnchor(firstAnchorType: .firstB, content: content)
    }
    class func centerY(_ content: Any...) -> AutoAnchor {
        return AutoAnchor(firstAnchorType: .centerY, content: content)
    }
    class func lastB(_ content: Any...) -> AutoAnchor {
        return AutoAnchor(firstAnchorType: .lastB, content: content)
    }
    class func bottom(_ content: Any...) -> AutoAnchor {
        return AutoAnchor(firstAnchorType: .bottom, content: content)
    }
    class func width(_ content: Any...) -> AutoAnchor {
        return AutoAnchor(firstAnchorType: .width, content: content)
    }
    class func height(_ content: Any...) -> AutoAnchor {
        return AutoAnchor(firstAnchorType: .height, content: content)
    }
    
    init(firstAnchorType: Anchor, content: [Any]) {
        self.firstAnchorType = firstAnchorType
        self.content = content
    }
    
    /* class methods */
    class func createConstraint(firstAnchor: AutoAnchor, secondAnchor: (NSLayoutXAxisAnchor?, NSLayoutYAxisAnchor?, NSLayoutDimension?), originalView: UIView?) -> NSLayoutConstraint? {
        
        var originalView = originalView
        var viewChanged = false, constantChanged = false, multiplierChanged = false
        var constant: CGFloat = 0, multiplier: CGFloat = 1
        
        var anchor: Anchor?
        var priority: UILayoutPriority = UILayoutPriority(1000)
        for item in firstAnchor.content {
            let itemAsUIView = item as? UIView
            if let view = itemAsUIView {
                if !viewChanged {
                    originalView = view
                    viewChanged = true
                }
            }
            
            var itemAsCGFloat: CGFloat?
            if let num = item as? CGFloat { itemAsCGFloat = num }
            if let num = item as? Int { itemAsCGFloat = CGFloat(num) }
            if let num = item as? Double { itemAsCGFloat = CGFloat(num) }
            if let num = item as? Float { itemAsCGFloat = CGFloat(num) }
            
            if let num = itemAsCGFloat {
                if !constantChanged {
                    constant = num
                    constantChanged = true
                }
                else if !multiplierChanged {
                    multiplier = num
                    multiplierChanged = true
                }
            }
            let itemAsAnchor = item as? Anchor
            if let anc = itemAsAnchor {
                anchor = anc
            }
            
            let itemAsPriority = item as? UILayoutPriority
            if let pri = itemAsPriority {
                priority = pri
            }
        }
        
        //if array was empty and originalview is specified, then set anchor to specified view and same anchor
        guard let view = originalView else {
            //if there is no view set, then must be a width or height anchor with only a constant
            guard let dimension = secondAnchor.2 else { return nil }
            let c = dimension.constraint(equalToConstant: constant)
            c.priority = priority
            return c
        }
        
        //get the constraint of view that originalView will be set to
        var returnedConstraints: (NSLayoutXAxisAnchor?, NSLayoutYAxisAnchor?, NSLayoutDimension?)
        if let type = anchor {
            returnedConstraints = type.getAnchor(view: view)
        }
        else {
            //if there is no anchor set, check and if current constraint is width and height anchor, then its position is simply set to static
            if let dimension = secondAnchor.2  {
                if multiplier != 1 || viewChanged || constant == 0 {
                    returnedConstraints = firstAnchor.firstAnchorType.getAnchor(view: view)
                    let c = dimension.constraint(equalTo: returnedConstraints.2!, multiplier: multiplier, constant: constant)
                    c.priority = priority
                    return c
                }
                else {
                    let c = dimension.constraint(equalToConstant: constant)
                    c.priority = priority
                    return c
                }
                
            }
            //else go on
            returnedConstraints = firstAnchor.firstAnchorType.getAnchor(view: view)
        }
        
        //set the constraint of this view to returned constraint
        if let xAnchor = secondAnchor.0 {
            let c = xAnchor.constraint(equalTo: returnedConstraints.0!, constant: constant)
            c.priority = priority
            return c
        }
        else if let yAnchor = secondAnchor.1 {
            let c = yAnchor.constraint(equalTo: returnedConstraints.1!, constant: constant)
            c.priority = priority
            return c
        }
        else {
            //for width dimensions
            let c = secondAnchor.2?.constraint(equalTo: returnedConstraints.2!, multiplier: multiplier, constant: constant)
            c?.priority = priority
            return c
        }
    }
}

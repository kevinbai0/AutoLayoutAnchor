//
//  ConstraintAnchors.swift
//  TiltDrop
//
//  Created by Kevin Bai on 2017-08-05.
//  Copyright © 2017 Kevin Bai. All rights reserved.
import Foundation
import UIKit

private struct ALConstraintManager {
    static var x1Constraint: [String: (ALAnchor?, NSLayoutConstraint?)] = [:] // default values
    static var x2Constraint: [String: (ALAnchor?, NSLayoutConstraint?)] = [:]
    static var widthConstraint: [String: (ALAnchor?, NSLayoutConstraint?)] = [:]
    static var y1Constraint: [String: (ALAnchor?, NSLayoutConstraint?)] = [:]
    static var y2Constraint: [String: (ALAnchor?, NSLayoutConstraint?)] = [:]
    static var heightConstraint: [String: (ALAnchor?, NSLayoutConstraint?)] = [:]
    
    static func deactivateConstraints(identifier: String) {
        
        ALConstraintManager.x1Constraint[identifier]?.1?.isActive = false
        ALConstraintManager.x2Constraint[identifier]?.1?.isActive = false
        ALConstraintManager.widthConstraint[identifier]?.1?.isActive = false
        ALConstraintManager.y1Constraint[identifier]?.1?.isActive = false
        ALConstraintManager.y2Constraint[identifier]?.1?.isActive = false
        ALConstraintManager.heightConstraint[identifier]?.1?.isActive = false
    }
    
    static func updateConstraints(identifier: String, constraints: [NSLayoutConstraint?], anchors: [ALAnchor], x1Index: Int?, x2Index: Int?, widthIndex: Int?, y1Index: Int?, y2Index: Int?, heightIndex: Int?) {
        ALConstraintManager.deactivateConstraints(identifier: identifier)
        
        if let x1 = x1Index {
            ALConstraintManager.x1Constraint[identifier] = (anchors[x1], constraints[x1])
            ALConstraintManager.x1Constraint[identifier]?.1?.isActive = true
        }
        if let x2 = x2Index {
            ALConstraintManager.x2Constraint[identifier] = (anchors[x2], constraints[x2])
            ALConstraintManager.x2Constraint[identifier]?.1?.isActive = true
        }
        else {
            ALConstraintManager.x2Constraint[identifier] = nil
        }
        if let w = widthIndex {
            ALConstraintManager.widthConstraint[identifier] = (anchors[w], constraints[w])
            ALConstraintManager.widthConstraint[identifier]?.1?.isActive = true
        }
        else {
            ALConstraintManager.widthConstraint[identifier] = nil
        }
        if let y1 = y1Index {
            ALConstraintManager.y1Constraint[identifier] = (anchors[y1], constraints[y1])
            ALConstraintManager.y1Constraint[identifier]?.1?.isActive = true
        }
        if let y2 = y2Index {
            ALConstraintManager.y2Constraint[identifier] = (anchors[y2], constraints[y2])
            ALConstraintManager.y2Constraint[identifier]?.1?.isActive = true
        }
        else {
            ALConstraintManager.y2Constraint[identifier] = nil
        }
        if let h = heightIndex {
            ALConstraintManager.heightConstraint[identifier] = (anchors[h], constraints[h])
            ALConstraintManager.heightConstraint[identifier]?.1?.isActive = true
        }
        else {
            ALConstraintManager.heightConstraint[identifier] = nil
        }
    }
}

extension UIView {
    func addToView(_ view: UIView, _ anchors: ALAnchor...) {
        view.addSubview(self) // view is now this view's superview
        self.addConstraints(anchors: anchors)
    }
    
    //set constraints
    func setConstraints(_ anchors: ALAnchor...) {
        addConstraints(anchors: anchors)
    }
    
    //function to add constraints
    private func addConstraints(anchors: [ALAnchor]) {
        self.translatesAutoresizingMaskIntoConstraints = false
        // for each anchor view, if the view isn't nil, then it's anchorView to the view
        var constraints: [NSLayoutConstraint?] = []
        var x1Index: Int?, x2Index: Int?, widthIndex: Int?
        var y1Index: Int?, y2Index: Int?, heightIndex: Int?
        
        for i in 0..<anchors.count {
            if anchors[i].firstAnchorType.dimension == .x {
                if x1Index == nil {
                    x1Index = i
                }
                else {
                    if anchors[i].firstAnchorType.rawValue < anchors[x1Index!].firstAnchorType.rawValue {
                        x2Index = x1Index
                        x1Index = i
                    }
                    else {
                        x2Index = i
                    }
                }
            }
            else if anchors[i].firstAnchorType.dimension == .y {
                if y1Index == nil {
                    y1Index = i
                }
                else {
                    if anchors[i].firstAnchorType.rawValue < anchors[y1Index!].firstAnchorType.rawValue {
                        y2Index = y1Index
                        y1Index = i
                    }
                    else {
                        y2Index = i
                    }
                }
            }
            else if anchors[i].firstAnchorType.dimension == .size {
                if anchors[i].firstAnchorType == .width {
                    widthIndex = i
                }
                else {
                    heightIndex = i
                }
            }
            
            // create a constraint based on the anchors
            constraints.append(addConstraint(anchor: anchors[i]))
        }
        
        let identifier = String(format: "%p", unsafeBitCast(self, to: Int.self))
        
        ALConstraintManager.updateConstraints(identifier: identifier, constraints: constraints, anchors: anchors, x1Index: x1Index, x2Index: x2Index, widthIndex: widthIndex, y1Index: y1Index, y2Index: y2Index, heightIndex: heightIndex)
        
        // only accceptable constraint values
        // 2 x anchors and 0 width ones, or 1 x anchor and 1 width anchor
        // 2 y anchors and 0 height ones, or 1 y anchor and 1 height anchor
    }
    
    var x1Anchor: ALAnchor? {
        get {
            let identifier = String(format: "%p", unsafeBitCast(self, to: Int.self))
            return ALConstraintManager.x1Constraint[identifier]?.0
        }
        set {
            let identifier = String(format: "%p", unsafeBitCast(self, to: Int.self))
            guard let newAnchor = newValue else { return }
            ALConstraintManager.x1Constraint[identifier]?.1?.isActive = false
            let constraint = self.addConstraint(anchor: newAnchor)
            constraint?.isActive = true
            ALConstraintManager.x1Constraint[identifier] = (newValue, constraint)
        }
    }
    var x2Anchor: ALAnchor? {
        get {
            let identifier = String(format: "%p", unsafeBitCast(self, to: Int.self))
            return ALConstraintManager.x2Constraint[identifier]?.0
        }
        set {
            let identifier = String(format: "%p", unsafeBitCast(self, to: Int.self))
            guard let newAnchor = newValue else { return }
            ALConstraintManager.x2Constraint[identifier]?.1?.isActive = false
            let constraint = self.addConstraint(anchor: newAnchor)
            constraint?.isActive = true
            ALConstraintManager.x2Constraint[identifier] = (newValue, constraint)
        }
    }
    
    var widthALAnchor: ALAnchor? {
        get {
            let identifier = String(format: "%p", unsafeBitCast(self, to: Int.self))
            return ALConstraintManager.widthConstraint[identifier]?.0
        }
        set {
            let identifier = String(format: "%p", unsafeBitCast(self, to: Int.self))
            guard let newAnchor = newValue else { return }
            ALConstraintManager.widthConstraint[identifier]?.1?.isActive = false
            let constraint = self.addConstraint(anchor: newAnchor)
            constraint?.isActive = true
            ALConstraintManager.widthConstraint[identifier] = (newValue, constraint)
        }
    }
    
    var y1Anchor: ALAnchor? {
        get {
            let identifier = String(format: "%p", unsafeBitCast(self, to: Int.self))
            return ALConstraintManager.y1Constraint[identifier]?.0
        }
        set {
            let identifier = String(format: "%p", unsafeBitCast(self, to: Int.self))
            guard let newAnchor = newValue else { return }
            ALConstraintManager.y1Constraint[identifier]?.1?.isActive = false
            let constraint = self.addConstraint(anchor: newAnchor)
            constraint?.isActive = true
            ALConstraintManager.y1Constraint[identifier] = (newValue, constraint)
        }
    }
    var y2Anchor: ALAnchor? {
        get {
            let identifier = String(format: "%p", unsafeBitCast(self, to: Int.self))
            return ALConstraintManager.y2Constraint[identifier]?.0
        }
        set {
            let identifier = String(format: "%p", unsafeBitCast(self, to: Int.self))
            guard let newAnchor = newValue else { return }
            ALConstraintManager.y2Constraint[identifier]?.1?.isActive = false
            let constraint = self.addConstraint(anchor: newAnchor)
            constraint?.isActive = true
            ALConstraintManager.y2Constraint[identifier] = (newValue, constraint)
        }
    }
    var heightALAnchor: ALAnchor? {
        get {
            let identifier = String(format: "%p", unsafeBitCast(self, to: Int.self))
            return ALConstraintManager.heightConstraint[identifier]?.0
        }
        set {
            let identifier = String(format: "%p", unsafeBitCast(self, to: Int.self))
            guard let newAnchor = newValue else { return }
            ALConstraintManager.heightConstraint[identifier]?.1?.isActive = false
            let constraint = self.addConstraint(anchor: newAnchor)
            constraint?.isActive = true
            ALConstraintManager.heightConstraint[identifier] = (newValue, constraint)
        }
    }
    
    
    
    func addConstraint(anchor: ALAnchor) -> NSLayoutConstraint? {
        // if the anchor's anchor view is not specified, than set it to it's superview (if no superview, then it will be nil)
        if anchor.secondView == nil {
            if let superView = self.superview {
                anchor.secondView = superView
            }
        }
        // each anchor's first view is self
        anchor.anchorView = self
        
        let createdConstraint = ALAnchor.createConstraint(anchor: anchor)
        return createdConstraint
    }
    
    func xLayoutAnchor(anchorType: AnchorType) -> NSLayoutXAxisAnchor? {
        if anchorType.dimension == .x {
            if anchorType == .left { return self.leftAnchor }
            else if anchorType == .right { return self.rightAnchor }
            else if anchorType == .leading { return self.leadingAnchor }
            else if anchorType == .trailing { return self.trailingAnchor }
            else if anchorType == .centerX { return self.centerXAnchor }
        }
        return nil
    }
    func yLayoutAnchor(anchorType: AnchorType) -> NSLayoutYAxisAnchor? {
        if anchorType.dimension == .y {
            if anchorType == .top { return self.topAnchor }
            else if anchorType == .firstB { return self.firstBaselineAnchor }
            else if anchorType == .centerY { return self.centerYAnchor }
            else if anchorType == .lastB { return self.lastBaselineAnchor }
            else if anchorType == .bottom { return self.bottomAnchor }
        }
        return nil
    }
    
    func dimensionLayoutAnchor(anchorType: AnchorType) -> NSLayoutDimension? {
        if anchorType.dimension == .size {
            if anchorType == .width { return self.widthAnchor }
            else if anchorType == .height { return self.heightAnchor }
            
        }
        return nil
    }
}

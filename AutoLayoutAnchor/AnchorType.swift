//
//  AnchorType.swift
//  AutoLayoutAnchor
//
//  Created by Kevin Bai on 2018-05-21.
//  Copyright © 2018 Kevin Bai. All rights reserved.
//

import Foundation

enum AnchorType: Int {
    case leading = 0, left = 1, centerX = 2, right = 3, trailing = 4, top = 5, firstB = 6, centerY = 7, lastB = 8, bottom = 9, width = 10, height = 11
    
    var dimension: AnchorDimension {
        get {
            switch self {
            case .leading:
                return .x
            case .left:
                return .x
            case .centerX:
                return .x
            case .right:
                return .x
            case .trailing:
                return .x
            case .top:
                return .y
            case .firstB:
                return .y
            case .centerY:
                return .y
            case .lastB:
                return .y
            case .bottom:
                return .y
            case .width:
                return .size
            case .height:
                return .size
            }
        }
    }
    
    var hasNaturallyPositiveConstants: Bool {
        get {
            switch self {
            case .leading:
                return true
            case .left:
                return true
            case .centerX:
                return true
            case .right:
                return false
            case .trailing:
                return false
            case .top:
                return true
            case .firstB:
                return true
            case .centerY:
                return true
            case .lastB:
                return false
            case .bottom:
                return false
            case .width:
                return true
            case .height:
                return true
            }
        }
    }
}

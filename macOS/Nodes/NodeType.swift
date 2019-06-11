//
//  NodeType.swift
//  Ant Saver
//
//  Created by Bradley Root on 6/8/19.
//  Copyright © 2019 Brad Root. All rights reserved.
//

import SpriteKit

enum NodeType: CaseIterable {
    case lava
    case rock
    case dirt
    case foliage
    case sand
    case water
    case empty

    func getNext() -> NodeType {
        switch self {
        case .lava:
            return .rock
        case .rock:
            return .dirt
        case .dirt:
            return .foliage
        case .foliage:
            return .foliage
        case .sand:
            return .sand
        case .water:
            return .water
        case .empty:
            return .water
        }
    }

    func getColor() -> SKColor {
        switch self {
        case .lava:
            return SKColor(hue: 0.9861, saturation: 0.92, brightness: 0.81, alpha: 1.0)
        case .rock:
            return SKColor(hue: 0, saturation: 0.19, brightness: 0.17, alpha: 1.0)
        case .dirt:
            return SKColor(hue: 0.0361, saturation: 0.46, brightness: 0.43, alpha: 1.0)
        case .foliage:
            return SKColor(hue: 0.225, saturation: 1, brightness: 0.59, alpha: 1.0)
        case .sand:
            return SKColor(hue: 0.125, saturation: 0.34, brightness: 0.79, alpha: 1.0)
        case .water:
            return SKColor(hue: 0.5528, saturation: 1, brightness: 0.67, alpha: 1.0)
        case .empty:
            return SKColor.black
        }
    }

    func canPaint(type: NodeType) -> Bool {
        if type == self {
            return true
        }
        switch (self, type) {
        case (.lava, .water):
            return true
//        case (.rock, .lava):
//            return true
//        case (.dirt, .rock):
//            return true
//        case (.foliage, .dirt):
//            return true
//        case (.sand, .foliage):
//            return true
//        case (.water, .water):
//            return false
        case (.water, .sand):
            return true
        default:
            return false
        }
    }
}

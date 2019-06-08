//
//  AntNode.swift
//  Ant Saver
//
//  Created by Bradley Root on 6/7/19.
//  Copyright © 2019 Brad Root. All rights reserved.
//

import SpriteKit

class AntNode: SKSpriteNode {
    public var heading: Direction
    public var currentPosition: (Int, Int)
    public let placeColor: SKColor

    init(heading: Direction, position: (Int, Int), size: CGSize, color: SKColor) {
        self.heading = heading
        self.currentPosition = position
        self.placeColor = color
        super.init(texture: squareTexture, color: .red, size: size)
        anchorPoint = CGPoint(x: 0, y: 0)
        colorBlendFactor = 1
        zPosition = 1
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func turnLeft() {
        heading = heading.turningLeft
    }

    public func turnRight() {
        heading = heading.turningRight
    }

    // MARK: - Moving
    public func moveForward() {
        switch heading {
        case .north:
            currentPosition = (currentPosition.0, currentPosition.1 + 1)
        case .east:
            currentPosition = (currentPosition.0 + 1, currentPosition.1)
        case .south:
            currentPosition = (currentPosition.0, currentPosition.1 - 1)
        case .west:
            currentPosition = (currentPosition.0 - 1, currentPosition.1)
        }
    }
}

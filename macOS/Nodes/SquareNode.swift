//
//  SquareNode.swift
//  Ant Saver
//
//  Created by Brad Root on 6/7/19.
//  Copyright © 2019 Brad Root. All rights reserved.
//

import SpriteKit


let squareTexture = FileGrabber.shared.getSKTexture(named: "square")

class SquareNode: SKSpriteNode {
    let relativePosition: CGPoint
    var currentColor: SKColor
    var neighbors: [SquareNode] = []
    var isFilled: Bool = false

    var type: NodeType = .empty {
        didSet {
            self.currentColor = self.type.getColor()
            self.color = self.type.getColor()
        }
    }


    init(relativePosition: CGPoint, type: NodeType, size: CGSize) {
        self.relativePosition = relativePosition
        self.type = type
        self.isFilled = Float.random(in: 0...5) <= 0.5 ? true : false
        self.currentColor = type.getColor()
        super.init(texture: squareTexture, color: self.currentColor, size: size)
        self.color = color
        anchorPoint = CGPoint(x: 0, y: 0)
        colorBlendFactor = 1
        zPosition = 0
        alpha = isFilled ? 1 : 0.8
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func updateType() {
        var nextType = self.type.getNext()

        let waterNeighbors = neighbors.filter { $0.type == .water }
        let sandNeighbors = neighbors.filter { $0.type == .sand }
        let foliageNeighbors = neighbors.filter { $0.type == .foliage }
        let lavaNeighbors = neighbors.filter { $0.type == .lava }
        let rockNeighbors = neighbors.filter { $0.type == .rock }

        if nextType == .foliage {
            if sandNeighbors.count == 4 {
                nextType = .sand
            } else if waterNeighbors.count >= 2 {
                nextType = .sand
            } else if foliageNeighbors.count >= 5 {
                nextType = .foliage
            } else if rockNeighbors.count >= 3 {
                nextType = .rock
            }
        } else if nextType == .sand {
            if foliageNeighbors.count >= 6 {
                nextType = .foliage
            } else if waterNeighbors.count >= 5 {
                nextType = .water
            } else if rockNeighbors.count >= 3 {
                nextType = .rock
            }
        }

        if !lavaNeighbors.isEmpty {
            nextType = .rock
        }

        changeType(nextType)
    }

    public func changeType(_ type: NodeType) {
        self.removeAllActions()
        self.type = type
        if self.type != .water {
            repeatUpdate()
        }
    }

    private func repeatUpdate() {
        let delay = SKAction.wait(forDuration: 5)
        let action = SKAction.run {
            self.updateType()
        }
        self.run(SKAction.sequence([delay, action]))
    }

}

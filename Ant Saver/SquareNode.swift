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

    init(relativePosition: CGPoint, color: SKColor, size: CGSize) {
        self.relativePosition = relativePosition
        self.currentColor = color
        super.init(texture: squareTexture, color: color, size: size)
        anchorPoint = CGPoint(x: 0, y: 0)
        colorBlendFactor = 1
        zPosition = 0
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

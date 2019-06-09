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
    var type: NodeType = .empty
    

    init(relativePosition: CGPoint, type: NodeType, size: CGSize) {
        self.relativePosition = relativePosition
        self.type = type
        self.currentColor = type.getColor()
        self.isFilled = Float.random(in: 0...5) <= 0.5 ? true : false
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

}

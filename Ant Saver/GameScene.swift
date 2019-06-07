//
//  GameScene.swift
//  Ant Saver
//
//  Created by Brad Root on 6/7/19.
//  Copyright © 2019 Brad Root. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {

    private var allNodes: [SquareNode] = []

    override func sceneDidLoad() {
        size.width = frame.size.width * 2
        size.height = frame.size.height * 2
    }
    
    override func didMove(to view: SKView) {
        backgroundColor = .black
        scaleMode = .fill
        createGrid()
    }
    
    
    func touchDown(atPoint pos : CGPoint) {

    }
    
    func touchMoved(toPoint pos : CGPoint) {

    }
    
    func touchUp(atPoint pos : CGPoint) {

    }
    
    override func mouseDown(with event: NSEvent) {
        self.touchDown(atPoint: event.location(in: self))
    }
    
    override func mouseDragged(with event: NSEvent) {
        self.touchMoved(toPoint: event.location(in: self))
    }
    
    override func mouseUp(with event: NSEvent) {
        self.touchUp(atPoint: event.location(in: self))
    }
    
    override func keyDown(with event: NSEvent) {
        switch event.keyCode {
        default:
            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
        }
    }
    
    private var lastUpdate: TimeInterval = 0
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if lastUpdate == 0 {
            // Create Grid
            lastUpdate = currentTime
        }
    }
}

extension GameScene {

    func createGrid() {
        let lengthSquares: CGFloat = 300
        let heightSquares: CGFloat = 300

        let colors: [SKColor] = [.red, .green, .blue]

        let totalSquares: CGFloat = lengthSquares * heightSquares
        let squareWidth: CGFloat = size.width / lengthSquares
        let squareHeight: CGFloat = size.height / heightSquares

        // Create Nodes

        var createdSquares: CGFloat = 0
        var nextXValue: Int = 0
        var nextYValue: Int = 0
        var nextXPosition: CGFloat = 0
        var nextYPosition: CGFloat = 0
        while createdSquares < totalSquares {
            let squarePosition = CGPoint(x: nextXPosition, y: nextYPosition)
            let squareRelativePosition = CGPoint(x: nextXValue, y: nextYValue)
            let squareSize = CGSize(width: squareWidth, height: squareHeight)

            let newSquare = SquareNode(
                relativePosition: squareRelativePosition,
                color: colors.randomElement()!,
                size: squareSize
            )
            addChild(newSquare)
            newSquare.position = squarePosition

            allNodes.append(newSquare)

            createdSquares += 1

            if nextXValue == Int(lengthSquares) - 1 {
                nextXValue = 0
                nextXPosition = 0
                nextYValue += 1
                nextYPosition += squareHeight
            } else {
                nextXValue += 1
                nextXPosition += squareWidth
            }
        }

//        // Calculate Neighbors
//
//        for node in allNodes {
//            let neighbors = allNodes.filter {
//                let delta = (abs(node.relativePosition.x - $0.relativePosition.x), abs(node.relativePosition.y - $0.relativePosition.y))
//                switch delta {
//                case (1, 1), (1, 0), (0, 1):
//                    return true
//                default:
//                    return false
//                }
//            }
//            node.neighbors = neighbors
//        }
//
//        // Add edges to each other
//        let maxX = lengthSquares - 1
//        let maxY = heightSquares - 1
//        let edgeNodes = allNodes.filter { [0, maxX].contains($0.relativePosition.x) || [0, maxY].contains($0.relativePosition.y) }
//        for node in edgeNodes {
//            // Calculate looping neighbor's position
//            let newNeighborX: CGFloat = {
//                if node.relativePosition.x == 0 {
//                    return maxX
//                } else if node.relativePosition.x == maxX {
//                    return 0
//                }
//                return node.relativePosition.x
//            }()
//            let newNeighborY: CGFloat = {
//                if node.relativePosition.y == 0 {
//                    return maxY
//                } else if node.relativePosition.y == maxY {
//                    return 0
//                }
//                return node.relativePosition.y
//            }()
//
//            // Find nodes at that position
//            let newNeighborFilter = edgeNodes.filter {
//                $0.relativePosition.x == newNeighborX && $0.relativePosition.y == newNeighborY
//            }
//            if let newNeighbor = newNeighborFilter.first {
//                node.neighbors.append(newNeighbor)
//                newNeighbor.neighbors.append(node)
//            }
//        }


    }

}

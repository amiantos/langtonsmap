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

    private var matrix: ToroidalMatrix<SquareNode>?

    private var allNodes: [SquareNode] = []

    private var antNodes: [AntNode] = []

    override func sceneDidLoad() {
        size.width = frame.size.width * 2
        size.height = frame.size.height * 2
    }

    private var rows: Int = 70
    private var columns: Int = 140
//    private var rows: Int = 35
//    private var columns: Int = 70

    override func didMove(to view: SKView) {
        backgroundColor = .black
        scaleMode = .fill
        createGrid(columns: self.columns, rows: self.rows)
    }
    
    
    func touchDown(atPoint pos : CGPoint) {

    }
    
    func touchMoved(toPoint pos : CGPoint) {

    }
    
    func touchUp(atPoint pos : CGPoint) {

    }

    #if os(macOS)
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
    #endif

    override func update(_ currentTime: TimeInterval) {
        for antNode in antNodes {
            guard let currentNode = matrix?[antNode.currentPosition.0, antNode.currentPosition.1] else { return }
            antNode.position = currentNode.position
            if currentNode.isFilled {
                antNode.turnLeft()
                currentNode.isFilled = false
                if antNode.type.canPaint(type: currentNode.type) {
                    currentNode.changeType(antNode.type)
                    currentNode.alpha = 0.8
                }
            } else {
                antNode.turnRight()
                currentNode.isFilled = true
                if antNode.type.canPaint(type: currentNode.type) {
                    currentNode.changeType(antNode.type)
                    currentNode.alpha = 1
                }
            }
            antNode.currentPosition = (Int(currentNode.relativePosition.x), Int(currentNode.relativePosition.y))
            antNode.moveForward()
        }
    }
}

extension GameScene {

    func createGrid(columns: Int, rows: Int) {
        let lengthSquares: CGFloat = CGFloat(columns)
        let heightSquares: CGFloat = CGFloat(rows)

        matrix = ToroidalMatrix(
            rows: Int(lengthSquares),
            columns: Int(heightSquares),
            defaultValue: SquareNode(
                relativePosition: CGPoint.zero,
                type: .water,
                size: .zero)
        )

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
                type: .water,
                size: squareSize
            )
            addChild(newSquare)
            newSquare.position = squarePosition

            allNodes.append(newSquare)

            matrix![Int(squareRelativePosition.x), Int(squareRelativePosition.y)] = newSquare

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

        // Prefetch neighbors
        for node in allNodes {
            if let matrix = self.matrix {
            var neighbors: [SquareNode] = []
                neighbors.append(matrix[Int(node.relativePosition.x - 1), Int(node.relativePosition.y)])
                neighbors.append(matrix[Int(node.relativePosition.x + 1), Int(node.relativePosition.y)])
                neighbors.append(matrix[Int(node.relativePosition.x), Int(node.relativePosition.y + 1)])
                neighbors.append(matrix[Int(node.relativePosition.x), Int(node.relativePosition.y - 1)])
                neighbors.append(matrix[Int(node.relativePosition.x + 1), Int(node.relativePosition.y + 1)])
                neighbors.append(matrix[Int(node.relativePosition.x - 1), Int(node.relativePosition.y - 1)])
                neighbors.append(matrix[Int(node.relativePosition.x - 1), Int(node.relativePosition.y + 1)])
                neighbors.append(matrix[Int(node.relativePosition.x + 1), Int(node.relativePosition.y - 1)])
                node.neighbors = neighbors

            }
        }


        createAntNode(type: .water, size: CGSize(width: squareWidth, height: squareHeight))

        createAntNode(type: .lava, size: CGSize(width: squareWidth, height: squareHeight))
        createAntNode(type: .lava, size: CGSize(width: squareWidth, height: squareHeight))

//        createAntNode(type: .foliage, size: CGSize(width: squareWidth, height: squareHeight))
//
//        createAntNode(type: .sand, size: CGSize(width: squareWidth, height: squareHeight))

    }

    func createAntNode(type: NodeType, size: CGSize) {
        let randomPosition = (Int.random(in: 0...self.rows-1), Int.random(in: 0...self.columns-1))
        let headings: [Direction] = [.north, .south, .east, .west]
        let antNode = AntNode(
            heading: headings.randomElement()!,
            position: randomPosition,
            size: size,
            type: type
        )
        addChild(antNode)
        guard let node = matrix?[randomPosition.0, randomPosition.1] else { return }
        antNode.position = node.position
        antNode.currentPosition = (Int(node.relativePosition.x), Int(node.relativePosition.y))
        antNodes.append(antNode)
    }

}

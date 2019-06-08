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
    
    override func didMove(to view: SKView) {
        backgroundColor = .black
        scaleMode = .fill
        createGrid(columns: self.columns, rows: self.rows)

//        let  blur = CIFilter(name:"CIGaussianBlur",parameters: ["inputRadius": 30.0])
//        self.filter = blur
//        self.shouldRasterize = false
//        self.shouldEnableEffects = true
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
    private var lastLocation: (Int, Int) = (0, 0)
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if lastUpdate == 0 {
            lastUpdate = currentTime
        }

        for antNode in antNodes {

            guard let currentNode = matrix?[antNode.currentPosition.0, antNode.currentPosition.1] else { return }
            antNode.position = currentNode.position
            if currentNode.isFilled {
                antNode.turnLeft()
                currentNode.isFilled = false
                currentNode.alpha = 0.8
//                currentNode.color = .white
            } else {
                antNode.turnRight()
                currentNode.isFilled = true
                currentNode.alpha = 1
                currentNode.color = antNode.placeColor
            }
            antNode.currentPosition = (Int(currentNode.relativePosition.x), Int(currentNode.relativePosition.y))
            antNode.moveForward()

//            guard let randomNode = matrix?[
//                (antNode.currentPosition.0 + Int.random(in: -1...1)), (antNode.currentPosition.1 + Int.random(in: -1...1))
//                ] else { return }
//            antNode.position = randomNode.position
//            print(randomNode.position)
//            antNode.currentPosition = (Int(randomNode.relativePosition.x), Int(randomNode.relativePosition.y))
//            randomNode.color = antNode.placeColor

        }
    }
}

extension GameScene {

    func createAnt() {

    }

    func createGrid(columns: Int, rows: Int) {
        let lengthSquares: CGFloat = CGFloat(columns)
        let heightSquares: CGFloat = CGFloat(rows)

        matrix = ToroidalMatrix(
            rows: Int(lengthSquares),
            columns: Int(heightSquares),
            defaultValue: SquareNode(
                relativePosition: CGPoint.zero,
                color: .black,
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
                color: .black,
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

        var colors: [SKColor] = [
            SKColor(hue: 0.225, saturation: 1, brightness: 0.59, alpha: 1.0),
            SKColor(hue: 0.5528, saturation: 1, brightness: 0.67, alpha: 1.0),
            SKColor(hue: 0.125, saturation: 0.34, brightness: 0.79, alpha: 1.0),
            SKColor(hue: 0.0361, saturation: 0.46, brightness: 0.43, alpha: 1.0),
        ]
        for presetColor in colors {
            let randomPosition = (Int.random(in: 0...self.rows-1), Int.random(in: 0...self.columns-1))
            let headings: [Direction] = [.north, .south, .east, .west]
            let antNode = AntNode(
                heading: headings.randomElement()!,
                position: randomPosition,
                size: CGSize(width: squareHeight, height: squareHeight),
                color: presetColor
            )
            addChild(antNode)
            guard let node = matrix?[randomPosition.0, randomPosition.1] else { return }
            antNode.position = node.position
            antNode.currentPosition = (Int(node.relativePosition.x), Int(node.relativePosition.y))
            antNodes.append(antNode)
        }
        
    }

}

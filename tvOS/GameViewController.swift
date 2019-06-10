//
//  GameViewController.swift
//  Langton's Planet
//
//  Created by Brad Root on 6/10/19.
//  Copyright © 2019 Brad Root. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    var scene: GameScene?
    var skView: SKView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.isIdleTimerDisabled = true
        view = SKView(frame: UIScreen.main.bounds)
        scene = GameScene(size: view.bounds.size)

        scene!.scaleMode = .aspectFill
        skView = view as? SKView
        skView?.ignoresSiblingOrder = true
        skView?.showsFPS = true
        skView?.showsDrawCount = true
        skView?.showsNodeCount = true
        skView!.presentScene(scene)
    }

}

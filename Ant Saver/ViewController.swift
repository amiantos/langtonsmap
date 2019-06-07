//
//  ViewController.swift
//  Ant Saver
//
//  Created by Brad Root on 6/7/19.
//  Copyright © 2019 Brad Root. All rights reserved.
//

import Cocoa
import SpriteKit
import GameplayKit

class ViewController: NSViewController {

    @IBOutlet var skView: SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let scene = GameScene(size: view.frame.size)

        let skView = view as? SKView
        skView?.presentScene(scene)

        skView?.ignoresSiblingOrder = true
        skView?.showsDrawCount = true
        skView?.showsFPS = true
        skView?.showsNodeCount = true
    }
}


//
//  GameViewController.swift
//  BirdHelp
//
//  Created by user196294 on 4/4/21.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    @IBOutlet var scoreLabel: UILabel!
    var scene: GameScene!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") as? GameScene  {
                // Set the scale mode to scale to fit the window
                self.scene = (scene as! GameScene)
                scene.scaleMode = .aspectFill
                scene.gameViewController = self
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }
    //commentaire a mettre
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? BirdViewController {
            destination.controller = self
        }
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func didSelectBird(_ bird: Bird) {
        debugPrint(bird)
    }
    //comment
    @IBAction func didTapLeft(){
        scene.didTapLeft()
    }
    //comment
    @IBAction func didTapRight(){
        scene.didTapRight()
    }
    //comment
    @IBAction func didTapJump(){
        scene.didTapJump()
    }
    
}

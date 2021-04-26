//
//  GameViewController.swift
//  BirdHelp
//
//  Created by user196294 on 4/4/21.
//

import UIKit
import SpriteKit
import GameplayKit
// la classe gameviewcontroller hérite du type UIviewcontroller
class GameViewController: UIViewController {
    // on rattache le scoreLabel avec IBoutlet
    @IBOutlet var scoreLabel: UILabel!
    var scene: GameScene!

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(forName: GameOverViewController.notificationReset, object: nil, queue: .main) { _ in
            self.configurationScene()
        }
        NotificationCenter.default.addObserver(forName: notifAppGameWin, object: nil, queue: .main) { _ in
            let alertController = UIAlertController.init(title: "Win", message: "You win", preferredStyle: UIAlertController.Style.alert)
            let buttonC = UIAlertAction.init(title: "Okay", style: UIAlertAction.Style.default) { _ in
                NotificationCenter.default.post(name: GameOverViewController.notificationReset, object: nil)
            }
            alertController.addAction(buttonC)
            self.present(alertController, animated: true) {
                
            }
        }
        configurationScene()

    }
    
    func configurationScene() {
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") as? GameScene  {
                // Set the scale mode to scale to fit the window
                self.scene = (scene as! GameScene)
                scene.scaleMode = .aspectFit
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
    //systeme qui demande au systeme l'orientation et on veux que en landscape
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func didSelectBird(_ bird: Bird) {
        debugPrint(bird)
    }
    //comment
    var timerLeft: Timer?
    @IBAction func didTapLeft(){
        scene.didTapLeft()
        timerLeft = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false, block: { _ in
            self.scene.didTapLeftForever()
        })
    }
    
    @IBAction func didTouchUpLeft() {
        
        scene.didTapLeftTouchUp() //
        timerLeft?.invalidate()
    } // comment

    //comment
    var timerRight: Timer?
    @IBAction func didTapRight(){// comment
        scene.didTapRight()
        timerRight = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false, block: { _ in
            self.scene.didTapRightForever()
        })
    }
    @IBAction func didTouchUpRight() {
        scene.didTapRightTouchUp()
        timerRight?.invalidate()
    }    //comment

    
    @IBAction func didTapJump(){//comment
        scene.didTapJump()
    }
    
   
    
}

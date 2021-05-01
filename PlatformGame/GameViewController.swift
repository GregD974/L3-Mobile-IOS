//
//  GameViewController.swift
//  PlatformGame
//
//  Created by user196294 on 4/4/21.
//

import UIKit
import SpriteKit
import GameplayKit
// la classe gameviewcontroller hérite du type UIviewcontroller
class GameViewController: UIViewController {
    // on rattache le scoreLabel avec IBoutlet
    @IBOutlet var scoreLabel: ScoreLabel!
    var scene: GameScene!
    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        /*timer = Timer.scheduledTimer(withTimeInterval: 4, repeats: false, block: { _ in
            NotificationCenter.default.post(name: notifAppGameWin, object: nil)
        })*/
        NotificationCenter.default.addObserver(forName:notificationReset, object: nil, queue: .main) { _ in
            self.configurationScene()
            self.dismiss(animated: true, completion: nil)
        }
        NotificationCenter.default.addObserver(forName: notifAppGameWin, object: nil, queue: .main) { _ in
            let viewController = self.storyboard!.instantiateViewController(withIdentifier: "succes") as! SuccesViewController
            
            viewController.score = self.scoreLabel.score
            self.present(viewController, animated: true, completion: nil)
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
    //commentaire a mettre chap 7
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PlayerViewController {
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
    
    
    
    func didSelectPlayer() {
        
        dismiss(animated: true, completion: nil)
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
    } 

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

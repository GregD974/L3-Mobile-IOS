//
//  GameScene.swift
//  BirdHelp
//
//  Created by user196294 on 4/4/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var gameViewController: GameViewController!
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private var bird : SKSpriteNode! //commentaire a mettre
    private var timer : Timer?
  
    override func didMove(to view: SKView) {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            NotificationCenter.default.post(name: HeartStackView.enemyCollisionNotification, object: nil)
            NotificationCenter.default.post(name: ScoreLabel.scoreNotification, object: nil)
        })
        let currentBird = UserDefaults.standard.string(forKey: "bird")!
        let scoreInt =  UserDefaults.standard.integer(forKey: currentBird)
        gameViewController.scoreLabel.text = String(scoreInt)
        
        self.bird = (childNode(withName:"//Bird") as! SKSpriteNode) // Commentaire a mettre
        
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }

        
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
            
        }
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
        
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    //comment
    func  didTapLeft() {
        bird.run(SKAction.move(by: CGVector.init(dx: -15, dy: 0), duration: 0.1))
    }
    //comment
    func didTapLeftForever(){
        bird.run(.repeatForever(SKAction.move(by: CGVector.init(dx: -15, dy: 0), duration: 0.1)))
    }
    func didTapLeftTouchUp(){
        bird.removeAllActions()
    }    
    func  didTapRight() {
        bird.run(SKAction.move(by: CGVector.init(dx: 15, dy: 0), duration: 0.1))
        
    }
    func didTapRightForever(){
        bird.run(.repeatForever(SKAction.move(by: CGVector.init(dx: 15, dy: 0), duration: 0.1)))
    }    //comment
    
    func didTapRightTouchUp(){
        bird.removeAllActions()
        
    }
    
    func  didTapJump() {
        bird.run(SKAction.move(by: CGVector.init(dx: 0, dy: 100), duration: 0.1))
        
        
    }
}

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
    private var background : SKSpriteNode!
    private var floor1: SKSpriteNode!
    private var floor2: SKSpriteNode!
  
    override func didMove(to view: SKView) {
        //commentaire a mettre
        NotificationCenter.default.addObserver(forName: notifAppGameOver, object: nil, queue: .main) { _ in
            guard let vController = self.gameViewController.storyboard?.instantiateViewController(identifier: "gameover") else {
                return
            }
            self.gameViewController.present(vController, animated: true, completion: nil)
        }
        
        let currentBird = UserDefaults.standard.string(forKey: "bird")! // commentaire a mettre
        let scoreInt =  UserDefaults.standard.integer(forKey: currentBird)//commentaire a mettre
        gameViewController.scoreLabel.text = String(scoreInt) // commentaire a mettre
        
        self.bird = (childNode(withName:"//Bird") as! SKSpriteNode) // Commentaire a mettre
        self.background = (childNode(withName:"//bg") as! SKSpriteNode)
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        self.floor1 = self.childNode(withName: "//flor1") as? SKSpriteNode
        self.floor2 = self.childNode(withName: "//flor2") as? SKSpriteNode
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
    //Fonction pour que le personnage bouge de -15 sur la gauche avec un temps de 100 miliseconde pour le bouton gauche
    func  didTapLeft() {
        bird.run(SKAction.move(by: CGVector.init(dx: -15, dy: 0), duration: 0.1))
    }
    //fonction utiliser pour quand on reste appuyer sur le bouton cela répète le mouvement
    func didTapLeftForever(){
        background.run(.repeatForever(SKAction.move(by: CGVector.init(dx: 15, dy: 0), duration: 0.1)))
    }
    //fonction utiliser pour quand il arrête d'appuyer cela arrete le mouvement dans tout les cas
    func didTapLeftTouchUp(){
        background.removeAllActions()
    }    
    func  didTapRight() {
        background.run(SKAction.move(by: CGVector.init(dx: 15, dy: 0), duration: 0.1))
        floor1.run(SKAction.move(by: CGVector.init(dx: 15, dy: 0), duration: 0.1))
        floor2.run(SKAction.move(by: CGVector.init(dx: 15, dy: 0), duration: 0.1))
    }
    func didTapRightForever(){
        background.run(.repeatForever(SKAction.move(by: CGVector.init(dx: -15, dy: 0), duration: 0.1)))
            floor1.run(SKAction.move(by: CGVector.init(dx: 15, dy: 0), duration: 0.1))
    floor2.run(SKAction.move(by: CGVector.init(dx: 15, dy: 0), duration: 0.1))
    }
    
    func didTapRightTouchUp(){
        background.removeAllActions()
        floor1.removeAllActions()
        floor2.removeAllActions()
        
    }
    
    func  didTapJump() {
        bird.run(SKAction.move(by: CGVector.init(dx: 0, dy: 100), duration: 0.1))
        
        
    }
}

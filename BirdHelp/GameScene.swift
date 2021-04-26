//
//  GameScene.swift
//  BirdHelp
//
//  Created by user196294 on 4/4/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene,SKPhysicsContactDelegate {
    
    var gameViewController: GameViewController!
    
    
    private var bird : SKSpriteNode! //commentaire a mettre
   
    private var background : SKSpriteNode!
    private var floor1: SKSpriteNode!
    private var floor2: SKSpriteNode!
    // commentaire a mettre methode executer a chaque fois qu'il y a un contact avec objet
    func didBegin(_ contact: SKPhysicsContact) {
        guard let bodyAName = contact.bodyA.node?.name, let bodyBName = contact.bodyB.node?.name else {
            return
        }
        if bodyAName == "Coin" || bodyBName == "Coin"{
            NotificationCenter.default.post(name: ScoreLabel.scoreNotification, object: nil)
            if bodyAName == "Coin"{
                contact.bodyA.node?.removeFromParent()
            }else{
                contact.bodyB.node?.removeFromParent()
                
            }
        }
        if bodyAName == "water1Test" || bodyBName == "water1Test" {
            NotificationCenter.default.post(name: HeartStackView.enemyCollisionNotification, object: nil)
            if bodyAName == "water1Test"{
                contact.bodyA.node?.physicsBody?.contactTestBitMask = 0
                contact.bodyA.node?.physicsBody?.categoryBitMask = 0
            }else{
                contact.bodyB.node?.physicsBody?.categoryBitMask = 0
                contact.bodyB.node?.physicsBody?.contactTestBitMask = 0
                
            }
        }
        
        if bodyAName == "EndGame" || bodyBName == "EndGame"{
            NotificationCenter.default.post(name: notifAppGameWin , object: nil)
            if bodyAName == "EndGame"{
                contact.bodyA.node?.removeFromParent()
                
            }else{
                contact.bodyB.node?.removeFromParent()
                
            }
            
        }
        
        
    }
    
    
    override func didMove(to view: SKView) {
        //commentaire a mettre
        NotificationCenter.default.addObserver(forName: notifAppGameOver, object: nil, queue: .main) { _ in
            guard let vController = self.gameViewController.storyboard?.instantiateViewController(identifier: "gameover") else {
                return
            }
            self.gameViewController.present(vController, animated: true, completion: nil)
        }
        
        scene?.physicsWorld.contactDelegate = self
        
        let currentBird = UserDefaults.standard.string(forKey: "bird")! // commentaire a mettre
        let scoreInt =  UserDefaults.standard.integer(forKey: currentBird)//commentaire a mettre
        gameViewController.scoreLabel.text = String(scoreInt) // commentaire a mettre
        
        self.bird = (childNode(withName:"//Bird") as! SKSpriteNode) // Commentaire a mettre
        self.background = (childNode(withName:"//bg") as! SKSpriteNode)
        // Get label node from scene and store it for use later
        
        self.floor1 = self.childNode(withName: "//flor1") as? SKSpriteNode
        self.floor2 = self.childNode(withName: "//flor2") as? SKSpriteNode
     

        
    }
    
   
    
    func touchDown(atPoint pos : CGPoint) {
        
       
            
        
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {

        bird.position = pos
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
       
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        
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
        
    }
    func didTapRightForever(){
        background.run(.repeatForever(SKAction.move(by: CGVector.init(dx: -15, dy: 0), duration: 0.1)))
            
    }
    
    func didTapRightTouchUp(){
        background.removeAllActions()
        
        
    }
    
    func  didTapJump() {
        bird.run(SKAction.move(by: CGVector.init(dx: 0, dy: 100), duration: 0.1))
        
        
    }
}

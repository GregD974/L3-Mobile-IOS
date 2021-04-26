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
    
    
     //commentaire a mettre
   
    private var background : SKSpriteNode!
    private var perso : SKSpriteNode!
    private var plateforme : SKSpriteNode!
    private var coin : [SKNode] = []
    
    // commentaire a mettre methode executer a chaque fois qu'il y a un contact avec objet
    func didBegin(_ contact: SKPhysicsContact) {
        guard let bodyAName = contact.bodyA.node?.name, let bodyBName = contact.bodyB.node?.name else {
            return
        }
        print(bodyAName)
        print(bodyBName)
        print("---")
        if bodyAName == "Coin" || bodyBName == "Coin"{
            NotificationCenter.default.post(name: ScoreLabel.scoreNotification, object: nil)
            if bodyAName == "Coin"{
                contact.bodyA.node?.removeFromParent()
            }else{
                contact.bodyB.node?.removeFromParent()
                
            }
        }
        //A SUPPRIMER
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
        
         // Commentaire a mettre
        self.background = (childNode(withName:"//bg") as! SKSpriteNode)
        self.perso = (childNode(withName: "//perso")as! SKSpriteNode)
        self.plateforme = (childNode(withName: "//plateforme")as! SKSpriteNode)
        
        enumerateChildNodes(withName: "//Coin") { (coin, _) in
            self.coin.append(coin as! SKSpriteNode)
        }
        
        
     

        
    }
    
   
    
    func touchDown(atPoint pos : CGPoint) {
        
       
            
        
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {

       
        
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
    var dx:Int = 15
    var dxDuration:Double =  0.1
    func  didTapLeft() {
        background.run(SKAction.move(by: CGVector.init(dx: dx, dy: 0), duration: dxDuration))
        plateforme.run(SKAction.move(by: CGVector.init(dx: dx, dy: 0), duration: dxDuration))
        for item in coin{
            item.run(SKAction.move(by: CGVector.init(dx: dx, dy: 0), duration: dxDuration))
            
        }
    }
    //fonction utiliser pour quand on reste appuyer sur le bouton cela répète le mouvement
    func didTapLeftForever(){
        background.run(.repeatForever(SKAction.move(by: CGVector.init(dx: dx, dy: 0), duration: dxDuration)))
        plateforme.run(.repeatForever(SKAction.move(by: CGVector.init(dx: dx, dy: 0), duration: dxDuration)))
        for item in coin{
            item.run(.repeatForever(.move(by: CGVector.init(dx: dx, dy: 0), duration: dxDuration)))
            
        }    }
    //fonction utiliser pour quand il arrête d'appuyer cela arrete le mouvement dans tout les cas
    func didTapLeftTouchUp(){
        background.removeAllActions()
        plateforme.removeAllActions()
        for item in coin{
            item.removeAllActions()
            
        }
        
    }
    func  didTapRight() {
        background.run(SKAction.move(by: CGVector.init(dx: -dx, dy: 0), duration: dxDuration))
        plateforme.run(SKAction.move(by: CGVector.init(dx: -dx, dy: 0), duration: dxDuration))
        for item in coin{
            item.run(SKAction.move(by: CGVector.init(dx: -dx, dy: 0), duration: dxDuration))
            
        }
    }
    func didTapRightForever(){
        background.run(.repeatForever(SKAction.move(by: CGVector.init(dx: -dx, dy: 0), duration: dxDuration)))
        plateforme.run(.repeatForever(.move(by: CGVector.init(dx: -dx, dy: 0), duration: dxDuration)))
        for item in coin{
            item.run(.repeatForever(.move(by: CGVector.init(dx: -dx, dy: 0), duration: dxDuration)))
            
        }
        
    }
    
    func didTapRightTouchUp(){
        background.removeAllActions()
        plateforme.removeAllActions()
        for item in coin{
            item.removeAllActions()
            
        }
        
    }
    
    func  didTapJump() {
        perso.run(SKAction.applyImpulse(CGVector.init(dx: 0, dy: 20), duration: dxDuration))
        
        
    }
}

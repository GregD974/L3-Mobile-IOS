//
//  GameScene.swift
//  PlatformGame
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
    private var texturePont : SKSpriteNode!
    private var platHaut1 : SKSpriteNode!
    private var platHaut2 : SKSpriteNode!
    private var platHaut3 : SKSpriteNode!
    private var goldenPlat : SKSpriteNode!
    private var longPlateforme : SKSpriteNode!
    private var pontHaut : SKSpriteNode!
    
    private var longPlateforme2 : SKSpriteNode!
    private var ennemie : SKSpriteNode!
    private var limitLeft: SKSpriteNode!
    private var limitRight : SKSpriteNode!
    private var endGame : SKSpriteNode!
    
    
    
    
    // commentaire a mettre methode executer a chaque fois qu'il y a un contact avec objet
    func didBegin(_ contact: SKPhysicsContact) {
        guard let bodyAName = contact.bodyA.node?.name, let bodyBName = contact.bodyB.node?.name else {
            return
        }
        
        
        if bodyAName == "limitLeft" || bodyBName == "limitLeft"{
            //self.removeAllAct()
        }
        
        if bodyAName == "ennemie" || bodyBName == "ennemie"{
            
            NotificationCenter.default.post(name: HeartStackView.enemyCollisionNotification, object: nil)
            if bodyAName == "ennemie"{
                contact.bodyA.node?.removeFromParent()
                //contact.bodyA.node?.physicsBody?.contactTestBitMask = 0
            }else{
                contact.bodyB.node?.removeFromParent()
                //contact.bodyB.node?.physicsBody?.contactTestBitMask = 0
                
            }
            
        }
        
        if bodyAName == "Coin" || bodyBName == "Coin"{
            NotificationCenter.default.post(name: ScoreLabel.scoreNotification, object: nil)
            scene?.run(.playSoundFileNamed("coin", waitForCompletion: false))
            if bodyAName == "Coin"{
                contact.bodyA.node?.removeFromParent()
            }else{
                contact.bodyB.node?.removeFromParent()
                
            }
        }
        //A SUPPRIMER
        
        
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
        
        
        // Commentaire a mettre
        self.background = (childNode(withName:"//bg") as! SKSpriteNode)
        self.perso = (childNode(withName: "//perso")as! SKSpriteNode)
        self.plateforme = (childNode(withName: "//plateforme")as! SKSpriteNode)
        self.texturePont = (childNode(withName: "//texturePont")as! SKSpriteNode)
        self.platHaut1 = (childNode(withName: "//plateformeHaut1")as! SKSpriteNode)
        self.platHaut2 = (childNode(withName: "//plateformeHaut2")as! SKSpriteNode)
        self.platHaut3 = (childNode(withName: "//plateformeHaut3")as! SKSpriteNode)
        self.goldenPlat = (childNode(withName: "//goldenPlat")as! SKSpriteNode)
        self.longPlateforme = (childNode(withName: "//longPlateforme")as! SKSpriteNode)
        self.longPlateforme2 = (childNode(withName: "//longPlateforme2")as! SKSpriteNode)
        self.pontHaut = (childNode(withName: "//pontHaut")as! SKSpriteNode)
        
        self.ennemie = (childNode(withName: "//ennemie")as! SKSpriteNode)
        self.limitLeft = (childNode(withName: "//limitLeft")as! SKSpriteNode)
        self.limitRight = (childNode(withName: "//limitRight")as! SKSpriteNode)
        self.endGame = (childNode(withName: "//endGame")as! SKSpriteNode)
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
    
    func playerHasIntersectionWithEndGame() {
        if perso.intersects(endGame){
            NotificationCenter.default.post(name: notifAppGameWin, object: nil)
            
        }
    }
    override func update(_ currentTime: TimeInterval) {
        playerHasIntersectionWithEndGame()
        
        if background.action(forKey: "forever") != nil {

            if directionLeft {
                
                
                if !canMoveLeft(){
                    removeAllAct()
                }
                
            } else{
                if !canMoveRight(){
                    removeAllAct()
                }
            }
        }
    }
    func moveByXforever(_ x:Int, _ duration:Double){
        
        
        
        background.run(.repeatForever(SKAction.move(by: CGVector.init(dx: x, dy: 0), duration: duration)), withKey: "forever")
        plateforme.run(.repeatForever(.move(by: CGVector.init(dx: x, dy: 0), duration: duration)))
        texturePont.run(.repeatForever(.move(by: CGVector.init(dx: x, dy: 0), duration: duration)))
        platHaut1.run(.repeatForever(.move(by: CGVector.init(dx: x, dy: 0), duration: duration)))
        platHaut2.run(.repeatForever(.move(by: CGVector.init(dx: x, dy: 0), duration: duration)))
        platHaut3.run(.repeatForever(.move(by: CGVector.init(dx: x, dy: 0), duration: duration)))
        goldenPlat.run(.repeatForever(.move(by: CGVector.init(dx: x, dy: 0), duration: duration)))
        longPlateforme.run(.repeatForever(.move(by: CGVector.init(dx: x, dy: 0), duration: duration)))
        longPlateforme2.run(.repeatForever(.move(by: CGVector.init(dx: x, dy: 0), duration: duration)))
        pontHaut.run(.repeatForever(.move(by: CGVector.init(dx: x, dy: 0), duration: duration)))
        endGame.run(.repeatForever(SKAction.move(by: CGVector.init(dx: x, dy: 0), duration: duration)))
        
        ennemie.run(.repeatForever(.move(by: CGVector.init(dx: x, dy: 0), duration: duration)))
        if x > 0{
            perso.run(SKAction.init(named:"animateLeft" )!)
            
        }else{
            perso.run(SKAction.init(named:"animateRight" )!)
            
        }
        for item in coin{
            item.run(.repeatForever(SKAction.move(by: CGVector.init(dx: x, dy: 0), duration: duration)))
        }
    }
    func moveByX(_ x:Int, _ duration:Double){
        background.run(SKAction.move(by: CGVector.init(dx: x, dy: 0), duration: duration))
        plateforme.run(SKAction.move(by: CGVector.init(dx: x, dy: 0), duration: duration))
        texturePont.run(SKAction.move(by: CGVector.init(dx: x, dy: 0), duration: duration))
        platHaut1.run(SKAction.move(by: CGVector.init(dx: x, dy: 0), duration: duration))
        platHaut2.run(SKAction.move(by: CGVector.init(dx: x, dy: 0), duration: duration))
        platHaut3.run(SKAction.move(by: CGVector.init(dx: x, dy: 0), duration: duration))
        goldenPlat.run(SKAction.move(by: CGVector.init(dx: x, dy: 0), duration: duration))
        longPlateforme.run(SKAction.move(by: CGVector.init(dx: x, dy: 0), duration: duration))
        longPlateforme2.run(SKAction.move(by: CGVector.init(dx: x, dy: 0), duration: duration))
        pontHaut.run(SKAction.move(by: CGVector.init(dx: x, dy: 0), duration: duration))
        endGame.run(SKAction.move(by: CGVector.init(dx: x, dy: 0), duration: duration))
        ennemie.run(SKAction.move(by: CGVector.init(dx: x, dy: 0), duration: duration))
        if x > 0{
            perso.run(SKAction.init(named:"animateLeft" )!)
            
        }else{
            perso.run(SKAction.init(named:"animateRight" )!)
            
        }
        for item in coin{
            item.run(SKAction.move(by: CGVector.init(dx: x, dy: 0), duration: duration))
            
        }
    }
    func removeAllAct(){
        background.removeAllActions()
        plateforme.removeAllActions()
        texturePont.removeAllActions()
        platHaut1.removeAllActions()
        platHaut2.removeAllActions()
        platHaut3.removeAllActions()
        goldenPlat.removeAllActions()
        longPlateforme.removeAllActions()
        longPlateforme2.removeAllActions()
        pontHaut.removeAllActions()
        endGame.removeAllActions()
        perso.removeAllActions()
        ennemie.removeAllActions()
        
        
        
        for item in coin{
            item.removeAllActions()
            
        }
        
    }
    
    //Fonction pour que le personnage bouge de -15 sur la gauche avec un temps de 100 miliseconde pour le bouton gauche
    var dx:Int = 15
    var dxDuration:Double =  0.1
    var directionLeft: Bool = false
    func  didTapLeft() {
        directionLeft = true
        if canMoveLeft(){
            moveByX(dx, dxDuration)
        }
    }
    //fonction utiliser pour quand on reste appuyer sur le bouton cela répète le mouvement
    func didTapLeftForever(){
        if canMoveRight() {
            moveByXforever(dx, dxDuration)
        }
    }
    
    //fonction utiliser pour quand il arrête d'appuyer cela arrete le mouvement dans tout les cas
    func didTapLeftTouchUp(){
        removeAllAct()
        
    }
    func  didTapRight() {
        directionLeft = false
        if canMoveRight(){
            moveByX(-dx, dxDuration)
        }
    }
    func didTapRightForever(){
        if canMoveRight(){
            moveByXforever(-dx, dxDuration)
            
        }
        
    }
    
    func didTapRightTouchUp(){
        
        removeAllAct()
        
    }
    
    func  didTapJump() {
        perso.run(SKAction.applyImpulse(CGVector.init(dx: 0, dy: 80), duration: dxDuration))
        //perso.run(SKAction.applyImpulse(CGVector.init(dx: 0, dy: scene!.size.height * 0.10), duration: dxDuration))
        
        
    }
    func canMoveLeft() -> Bool{
        
        let oldPosition = background.position
        var newPositionLeft = background.position
        newPositionLeft.x += CGFloat(dx)
        background.position = newPositionLeft
        if background.intersects(limitRight){
            background.position = oldPosition
            
            return false
        }
        else{
            
            background.position = oldPosition
            return true
        }
    }
    func canMoveRight() -> Bool{
        let oldPosition = background.position
        var newPositionRight = background.position
        newPositionRight.x -= CGFloat(dx)
        background.position = newPositionRight
        
        if background.intersects(limitLeft){
            background.position = oldPosition
            
            return false
        }
        else{
            background.position = oldPosition
            
            return true
        }
    }
}


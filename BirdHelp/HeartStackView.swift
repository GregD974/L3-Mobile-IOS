//
//  HeartStackView.swift
//  BirdHelp
//
//  Created by user196294 on 4/17/21.
//

import UIKit

class HeartStackView:UIStackView {
    
    static let enemyCollisionNotification: Notification.Name = .init("notificationEnemyCollision")
    
    @IBOutlet var heartsConnect: [UIImageView]!
    
    override func awakeFromNib() {
        
        super.awakeFromNib() // fait la liaison avec UISTACKVIEW
        //On procede a une ecoute
        NotificationCenter.default.addObserver(forName: Self.enemyCollisionNotification, object: nil, queue: .main) { _ in
            let heartToHide = self.heartsConnect.reversed().first { (imageView) -> Bool in
                if imageView.isHidden == false {
                    return true
                } else {
                    return false
                }
            }
            heartToHide?.isHidden = true
            
            if self.testGameOver() {
                NotificationCenter.default.post(name: notifAppGameOver, object: nil)
            }
        } // notification pour clavier / appli fermer etc
        NotificationCenter.default.addObserver(forName: GameOverViewController.notificationReset, object: nil, queue: .main) { _ in
            for heart in self.heartsConnect{
                heart.isHidden = false
            }
        }
    }
    
    func testGameOver() -> Bool {
        var counter: Int = 0
        for item in heartsConnect {
            if item.isHidden{
                counter += 1
            }
        }
        if counter == 3 {
         return true
        }
        return false
    }
}

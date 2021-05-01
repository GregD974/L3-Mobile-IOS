//
//  HeartStackView.swift
//  PlatformGame
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
            // heartsConnect [heart1.isHidden false, heart2.isHidden false, heart3.isHidden true]
            // isHidden false == heart is visible ;  isHidden true == heart is lost
            // reversed [heart3 isHidden true, heart2 isHidden false, heart1 isHidden false]
            // heart3.isHidden,
            let heartToHide = self.heartsConnect.reversed().first { (heart) -> Bool in
                if heart.isHidden == false {
                    return true
                } else {
                    return false
                }
            }
            heartToHide?.isHidden = true
            
            if self.testGameOver() {
                NotificationCenter.default.post(name: notifAppGameOver, object: nil)
            }
        } //
        NotificationCenter.default.addObserver(forName: notificationReset, object: nil, queue: .main) { _ in
            for heart in self.heartsConnect{
                heart.isHidden = false
            }
        }
    }
    // on boucle sur les coeurs ,On crée un compteur quand il arrive a 3 cela veut dire que les 3 coeurs sont cacher donc qu'on doit declancher le GameOver
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

//
//  ScoreLabel.swift
//  BirdHelp
//
//  Created by user196294 on 4/17/21.
//

import UIKit


class ScoreLabel : UILabel {
     var score: Int = 0 // on definit le score de base
    static let scoreNotification : Notification.Name = Notification.Name.init("scoreNotification") // on crée la variable scoreNotification de type Notification.Name et on l'initialise au nom de scoreNotification
    
    
    // on crée la fonction awakeFromNib issue de la classe UiLabel , utilité :
    override  func awakeFromNib() {
        
        super.awakeFromNib() // fait la liaison avec UILabel
         //on procède a une écoute du thread pour augmenter le score de 1 et le convertir en string
        NotificationCenter.default.addObserver(forName: Self.scoreNotification, object: nil, queue: .main) { _ in
            self.score += 1
            self.text = String(self.score)
        }
        NotificationCenter.default.addObserver(forName: notificationReset, object: nil, queue: .main) { _ in
            let playerId = UserDefaults.standard.string(forKey: "playerID")!
            let highScore = UserDefaults.standard.integer(forKey: playerId)
            
            if self.score > highScore {
                UserDefaults.standard.setValue(self.score, forKey: playerId)
            }
            
           
            self.score = 0
            self.text = String(self.score)
            
        }
        
    }
    
    
    
}

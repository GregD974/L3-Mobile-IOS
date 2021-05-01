//
//  SuccesViewController.swift
//  PlatformGame
//
//  Created by user196294 on 4/29/21.
//

import UIKit

class SuccesViewController : UIViewController {
    @IBOutlet var scoreFinish : UILabel!
    @IBAction func didTapClose(){
        dismiss(animated: true) {
            NotificationCenter.default.post(name: notificationReset, object: nil)
        }
    }
    var score:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let playerId = UserDefaults.standard.string(forKey: kPlayerId)!
        let highScore = UserDefaults.standard.integer(forKey: "player" + String(playerId) + "HighScore")
        
        if score > highScore {
            UserDefaults.standard.setValue(self.score, forKey: "player" + String(playerId) + "HighScore")
        }
    
        scoreFinish.text = String(score)
    }
    
    
}

//
//  ScoreLabel.swift
//  BirdHelp
//
//  Created by user196294 on 4/17/21.
//

import UIKit


class ScoreLabel : UILabel {
    var score: Int = 0
    static let scoreNotification : Notification.Name = Notification.Name.init("scoreNotification")
    override  func awakeFromNib() {
        
        super.awakeFromNib()
        NotificationCenter.default.addObserver(forName: Self.scoreNotification, object: nil, queue: .main) { _ in
            self.score += 1
            self.text = String(self.score)
        }
        
    }
    
    
    
}

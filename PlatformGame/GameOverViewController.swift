//
//  GameOverViewController.swift
//  PlatformGame
//
//  Created by user196294 on 4/17/21.
//

import UIKit



class GameOverViewController: UIViewController {
    
    @IBAction func didTapReset(){
        NotificationCenter.default.post(name: notificationReset, object: nil)
    }
    
}

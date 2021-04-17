//
//  GameOverViewController.swift
//  BirdHelp
//
//  Created by user196294 on 4/17/21.
//

import UIKit



class GameOverViewController: UIViewController {
    static let notificationReset: Notification.Name = .init("NotificationReset")
    @IBAction func didTapReset(){
        NotificationCenter.default.post(name: Self.notificationReset, object: nil)
    }
    
}

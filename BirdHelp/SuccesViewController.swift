//
//  SuccesViewController.swift
//  BirdHelp
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
    
        scoreFinish.text = String(score)
    }
    
    
}

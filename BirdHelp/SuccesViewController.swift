//
//  SuccesViewController.swift
//  BirdHelp
//
//  Created by user196294 on 4/29/21.
//

import UIKit

class SuccesViewController : UIViewController {
    @IBOutlet var scoreFinish : UILabel!
    
    var score:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        scoreFinish.text = String(score)
    }
    
    
}

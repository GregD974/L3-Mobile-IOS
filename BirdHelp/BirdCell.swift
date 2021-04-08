//
//  Cell.swift
//  BirdHelp
//
//  Created by user196294 on 4/5/21.
//

import UIKit
//Permet d'acceder au éléments de la cellule 
class BirdCell: UITableViewCell {
    
    @IBOutlet var imageViewBird: UIImageView! // 
    @IBOutlet var label1: UILabel!
    @IBOutlet var label2: UILabel!
    @IBOutlet var label3: UILabel!
    
    func configure() {
        UIView.animate(withDuration: 0.2 , delay: 0, options: [.repeat,.autoreverse]) {
            self.imageViewBird.transform = .init(scaleX:1.2, y: 1.2)
        }
    }
}

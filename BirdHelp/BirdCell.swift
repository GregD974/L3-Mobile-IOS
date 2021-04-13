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
    
    //commentaire a mettre
    func configure() {//dispatchqueur receptionne la demande d'executer quelque chose c'est un thread, on ajoute 0,1 miliseconde apres le lancement de l'appli
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            UIView.animate(withDuration: 0.5 , delay: 0, options: [.repeat,.autoreverse]) {
                
                self.imageViewBird.transform = .init(scaleX:1.2, y: 1.2)
                
            }
        })

    }
}

//
//  BirdViewController.swift
//  BirdHelp
//
//  Created by user196294 on 4/6/21.
//

import Foundation
import UIKit
//UIviewcontroller : gestion de la liste des oiseaux,

class BirdViewController: UIViewController{
    
    @IBOutlet var tableView: UITableView!
    var birdTableViewDataSource: BirdTableViewDataSource!
    override func viewDidLoad() { //
        super.viewDidLoad() //
        
        birdTableViewDataSource = BirdTableViewDataSource.init()
        tableView.dataSource = birdTableViewDataSource
    }
}

class BirdTableViewDataSource: NSObject, UITableViewDataSource {
    
    var birds: [Bird] = {
        [
            Bird.init(name: "Chuck", highScore: 0, levelName: "Ocean" ,image: UIImage.init(named: "ally_chuck")!),
            Bird.init(name: "Will", highScore: 0, levelName: "Ville", image: UIImage.init(named: "ally_chuck")!),
            Bird.init(name: "Nuck", highScore: 0, levelName: "Montagne", image: UIImage.init(named: "ally_chuck")!),
            Bird.init(name: "Fox", highScore: 0, levelName: "Hiver", image:  UIImage.init(named: "ally_chuck")!)
        ]
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // nombre de ligne
        return birds.count // retourne 4 cellule / oiseau
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {//creer une cellule
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellBird") else {
            return UITableViewCell()
        }
        guard let cellBird = cell as? BirdCell else {
            return UITableViewCell()
        }
        cellBird.label1.text = birds[indexPath.row].name
        cellBird.label2.text = String(birds[indexPath.row].highScore)
        cellBird.label3.text = birds[indexPath.row].levelName
        cellBird.imageViewBird.image = birds[indexPath.row].image
        
        return cell
    }
    
    
}

struct Bird {
    var name:String
    var highScore:Int
    var levelName:String
    var image: UIImage
}

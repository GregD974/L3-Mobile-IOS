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
    
    weak var controller: GameViewController!//
    // commentaire a mettre
    @IBOutlet var tableView: UITableView!//
    var birdTableViewDataSourceAndDelegate: BirdTableViewDataSourceAndDelegate!//
    override func viewDidLoad() { //
        super.viewDidLoad() //
        
        birdTableViewDataSourceAndDelegate = BirdTableViewDataSourceAndDelegate.init() //
        birdTableViewDataSourceAndDelegate.controller = self//
        tableView.dataSource = birdTableViewDataSourceAndDelegate//
        tableView.delegate = birdTableViewDataSourceAndDelegate//
    }
    //commentaire a mettre
    func didSelectBird(_ bird: Bird) {
        controller.didSelectBird(bird)//
    }
    
}

class BirdTableViewDataSourceAndDelegate: NSObject, UITableViewDataSource,UITableViewDelegate {
    
    weak var controller: BirdViewController! //
    //Initialise les 4 oiseaux
    var birds: [Bird] = {
        let allyChuckScore = UserDefaults.standard.integer(forKey: "ally_chuck")
        
        
        return [
            Bird.init(name: "Chuck", highScore: allyChuckScore, levelName: "Ocean" ,image: UIImage.init(named: "ally_chuck")!),
        
        ]
    }()
    //commentaire a mettre
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // nombre de ligne
        return birds.count // retourne 4 cellule / oiseau
    }
    //commentaire a mettre
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {//creer une cellule
        //commentaire a mettre
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellBird") else {
            return UITableViewCell()
        }
        //commentaire a mettre as pour cast
        guard let cellBird = cell as? BirdCell else {
            return UITableViewCell()
        }
        //commentaire a mettre
        cellBird.label1.text = birds[indexPath.row].name // recupere le nom de chaque oiseaux
        cellBird.label2.text = String(birds[indexPath.row].highScore) //
        cellBird.label3.text = birds[indexPath.row].levelName
        cellBird.imageViewBird.image = birds[indexPath.row].image
        cellBird.configure()
        
        return cell
    }
    //savoir quelle celule est selectionner
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        controller.didSelectBird(birds[indexPath.row])
    }
    
}
//commentaire a mettre
struct Bird {
    var name:String
    var highScore:Int
    var levelName:String
    var image: UIImage
}

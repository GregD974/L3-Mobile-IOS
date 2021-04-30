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
    //pourquoi
    weak var controller: GameViewController!//
    // commentaire a mettre
    @IBOutlet var tableView: UITableView!//
    var birdTableViewDataSourceAndDelegate: BirdTableViewDataSourceAndDelegate!// pourquoi
    override func viewDidLoad() { //
        super.viewDidLoad() //
        //moyen de communication entre les ecran pour
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
            Bird.init(name: "Chuck 2", highScore: allyChuckScore, levelName: "Ocean" ,image: UIImage.init(named: "ally_chuck")!),
        
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

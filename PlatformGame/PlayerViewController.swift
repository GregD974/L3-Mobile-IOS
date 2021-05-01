//
//  PlayerViewController.swift
//  PlayerHelp
//
//  Created by user196294 on 4/6/21.
//

import Foundation
import UIKit
//UIviewcontroller : gestion de la liste des player,

class PlayerViewController: UIViewController{
    //pourquoi
    weak var controller: GameViewController!//
    // commentaire a mettre
    @IBOutlet var tableView: UITableView!//
    var playerTableViewDataSourceAndDelegate: PlayerTableViewDataSourceAndDelegate!// pourquoi
    override func viewDidLoad() { //
        super.viewDidLoad() //
        //moyen de communication entre les ecran pour
        playerTableViewDataSourceAndDelegate = PlayerTableViewDataSourceAndDelegate.init() //
        playerTableViewDataSourceAndDelegate.controller = self//
        tableView.dataSource = playerTableViewDataSourceAndDelegate//
        tableView.delegate = playerTableViewDataSourceAndDelegate//
    }
    //commentaire a mettre
    func didSelectPlayer(_ player: Player) {
        controller.didSelectPlayer(player)//
    }
    
}

class PlayerTableViewDataSourceAndDelegate: NSObject, UITableViewDataSource,UITableViewDelegate {
    
    weak var controller: PlayerViewController! //
    //Initialise les 4 personnage
    var players: [Player] = {
        let allyChuckScore = UserDefaults.standard.integer(forKey: "ally_chuck")
        
        
        return [
            Player.init(name: "Chuck", highScore: allyChuckScore, levelName: "Ocean" ,image: UIImage.init(named: "ally_chuck")!),
            Player.init(name: "Chuck 2", highScore: allyChuckScore, levelName: "Ocean" ,image: UIImage.init(named: "ally_chuck")!),
            Player.init(name: "Chuck 2", highScore: allyChuckScore, levelName: "Ocean" ,image: UIImage.init(named: "ally_chuck")!),
            Player.init(name: "Chuck 2", highScore: allyChuckScore, levelName: "Ocean" ,image: UIImage.init(named: "ally_chuck")!),
        ]
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // nombre de ligne
        return players.count // retourne 4 cellule
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {//creer une cellule
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellPlayer") else {
            return UITableViewCell()
        }
       
        guard let cellPlayer = cell as? PlayerCell else {
            return UITableViewCell()
        }
        
        cellPlayer.label1.text = players[indexPath.row].name // recupere le nom de chaque personnage
        cellPlayer.label2.text = String(players[indexPath.row].highScore) //
        cellPlayer.label3.text = players[indexPath.row].levelName
        cellPlayer.imageViewPlayer.image = players[indexPath.row].image
        cellPlayer.configure()
        
        return cell
    }
    //savoir quelle celule est selectionner
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        controller.didSelectPlayer(players[indexPath.row])
    }
    
}
//commentaire a mettre

struct Player {
    var name:String
    var highScore:Int
    var levelName:String
    var image: UIImage
}

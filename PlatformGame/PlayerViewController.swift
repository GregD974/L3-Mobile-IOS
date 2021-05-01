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
    func didSelectPlayer() {
        controller.didSelectPlayer()//
    }
    
}

class PlayerTableViewDataSourceAndDelegate: NSObject, UITableViewDataSource,UITableViewDelegate {
    
    weak var controller: PlayerViewController! //
    //Initialise les 4 personnage
    var players: [Player] = {
        let player1HighScore = UserDefaults.standard.integer(forKey: "player1HighScore")
        let player2HighScore = UserDefaults.standard.integer(forKey: "player2HighScore")
        let player3HighScore = UserDefaults.standard.integer(forKey: "player3HighScore")
        let player4HighScore = UserDefaults.standard.integer(forKey: "player4HighScore")
        
        let player1 = Player.init(id : 1, name: "PlayerName1", highScore: player1HighScore, levelName: "Ocean" ,spriteName: "player1Sprite")
        let player2 = Player.init(id: 2 ,name: "PlayerName2", highScore: player2HighScore, levelName: "Ocean" , spriteName: "player2Sprite")
        let player3 = Player.init(id: 3 ,name: "PlayerName3", highScore: player3HighScore, levelName: "Ocean" , spriteName: "player3Sprite")
        let player4 = Player.init(id: 4 ,name: "PlayerName4", highScore: player4HighScore, levelName: "Ocean" , spriteName: "player4Sprite")

        
        return [
           player1,
            player2,
            player3,
            player4,
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
        let image = UIImage.init(named: players[indexPath.row].spriteName)
        cellPlayer.imageViewPlayer.image = image
        cellPlayer.configure()
        
        return cell
    }
    //savoir quelle celule est selectionner
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let player = players[indexPath.row]
        UserDefaults.standard.set(player.id, forKey: kPlayerId)
        UserDefaults.standard.set(player.spriteName, forKey: kPlayerSprite)
        controller.didSelectPlayer()
        NotificationCenter.default.post(name: notificationDidSelectPlayer, object: nil)
    }
    
}
//commentaire a mettre

struct Player {
    var id: Int
    var name:String
    var highScore:Int
    var levelName:String
    var spriteName: String
}

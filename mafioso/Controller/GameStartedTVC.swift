//
//  gameStartedTVC.swift
//  mafioso
//
//  Created by Wameedh Mohammed Ali on 1/22/19.
//  Copyright © 2019 Wameedh Mohammed Ali. All rights reserved.
//

import UIKit
import Firebase

class GameStartedTVC: UITableViewController {
    
    
    var game: Game!
    
    //This array will be used to kick off all users from the game after the moderator termnate the game
    var arrayOfUsersIds: [String] = []
    
    @IBOutlet weak var endGameButton: UIButton!
    
    
    override func viewDidLoad() {
        setPositionEndGameButton()
        populateArrayOfUsersIds()
        self.tableView.rowHeight = 50.0
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch (section) {
        case 0:
            return "Innocents"
        case 1:
            return "Mafia"
        default:
            return "Others"
        }
        
    }
    
    public override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        //        header.backgroundView?.backgroundColor = .red
        //        header.textLabel?.textColor = .yellow
        header.textLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (section) {
        case 0:
            return game.innocentsGroup.count
        case 1:
            return game.mafiaGroup.count
        default:
            return game.othersGroup.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameStartedTVCCell", for: indexPath)
        
        let player: Player
        
        switch (indexPath.section) {
        case 0:
            player = game.innocentsGroup[indexPath.row]
        case 1:
            player = game.mafiaGroup[indexPath.row]
        default:
            player = game.othersGroup[indexPath.row]
        }
        
        cell.textLabel?.text = player.name
        cell.detailTextLabel?.text = player.role
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected")
    }
    
    //Populate the ArrayOfUsersIds with the ids of all users in the game
    func populateArrayOfUsersIds(){
        for i in self.game.players {
            arrayOfUsersIds.append(i.uid)
        }
    }
    
    
    private func setPositionEndGameButton() {
        // set position
        endGameButton.translatesAutoresizingMaskIntoConstraints = false
        endGameButton.leftAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.leftAnchor).isActive = true
        endGameButton.rightAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.rightAnchor).isActive = true
        endGameButton.bottomAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.bottomAnchor).isActive = true
        endGameButton.widthAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.widthAnchor).isActive = true
        endGameButton.heightAnchor.constraint(equalToConstant: 50).isActive = true // specify the height of the view if you want
    }

    
     // MARK: - IBAction
    @IBAction func endGameButtonPressed(_ sender: Any) {
        
        presentAlert(title: "Are you sure you want to quit?", message: "That means you will terminate your role in the game",vc: self, action:
            UIAlertAction(title: "Yes", style: .destructive, handler: { (_) in
            self.performSegue(withIdentifier: "unwindToNewJoinGame", sender: self)
        
                for i in self.arrayOfUsersIds {
        Database.database().reference().child("Users").child(i).removeValue()
                }
                }))
    }
    
}

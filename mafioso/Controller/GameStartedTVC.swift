//
//  gameStartedTVC.swift
//  mafioso
//
//  Created by Wameedh Mohammed Ali on 1/22/19.
//  Copyright © 2019 Wameedh Mohammed Ali. All rights reserved.
//

import UIKit
class GameStartedTVC: UITableViewController {
    
    
    var game: Game!
    
    
    @IBOutlet weak var endGameButton: UIButton!
    
    
    override func viewDidLoad() {
        setPositionEndGameButton()
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
    
    
    
    private func setPositionEndGameButton() {
        // set position
        endGameButton.translatesAutoresizingMaskIntoConstraints = false
        endGameButton.leftAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.leftAnchor).isActive = true
        endGameButton.rightAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.rightAnchor).isActive = true
        endGameButton.bottomAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.bottomAnchor).isActive = true
        endGameButton.widthAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.widthAnchor).isActive = true
        endGameButton.heightAnchor.constraint(equalToConstant: 50).isActive = true // specify the height of the view if you want
    }

    @IBAction func endGameButtonPressed(_ sender: Any) {
        
        presentAlert(title: "String", message: "Message", vc: self)
    }
    
}

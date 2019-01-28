//
//  editRolesTVC.swift
//  mafioso
//
//  Created by Wameedh Mohammed Ali on 1/23/19.
//  Copyright © 2019 Wameedh Mohammed Ali. All rights reserved.
//

import UIKit

class EditRolesTVC: UITableViewController {
    
    
    var game: Game!
    
    override func viewDidLoad() {
       
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "editRoleCell", for: indexPath)
        
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
    
    
}

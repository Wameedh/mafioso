//
//  editRolesTVC.swift
//  mafioso
//
//  Created by Wameedh Mohammed Ali on 1/23/19.
//  Copyright © 2019 Wameedh Mohammed Ali. All rights reserved.
//

import UIKit

class EditRolesTableVC: UITableViewController {
    
    
    var game: Game!
    var selectedPlayer: Player = Player()
    
    
    override func viewDidLoad() {
         NotificationCenter.default.addObserver(self, selector: #selector(self.catchNotificationFromFirebaseDataModel), name: .playersJoinedTheGameLabelHasBeenUpdated, object: nil)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Help", style: .done, target: self, action: #selector(helpTapped))
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Your Code Here...
        DispatchQueue.main.async (execute: { () -> Void in
            self.tableView.reloadData()
        })
    }
    
    
    
    @objc func catchNotificationFromFirebaseDataModel(notification: Notification) {
        
        if let dataModel = notification.object as? FirebaseDataModel {
           game = dataModel.data
        }
        
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
        
        switch (indexPath.section) {
        case 0:
            selectedPlayer = game.innocentsGroup[indexPath.row]
            
        case 1:
            selectedPlayer = game.mafiaGroup[indexPath.row]
            
        default:
           selectedPlayer = game.othersGroup[indexPath.row]
        }
        
        performSegue(withIdentifier: "toSelectingRoleTVC", sender: self)
        
    }
    
    
    @IBAction func helpTapped(_ sender: Any){
        self.performSegue(withIdentifier: "fromEditeRolesVCToHowToPlayDetails", sender: self)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toSelectingRoleTVC" {
            let destinationVC = segue.destination as? TableViewControllerForSelectingRole
            
          destinationVC?.player = selectedPlayer
        destinationVC?.gameCode = game.gameCode
            
        }
        
        
        
    }
    
    
}


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
    var IndexOfSection = 999
    var numberOfPlayersIsOne = false
    
    override func viewDidLoad() {
         super.viewDidLoad()
         NotificationCenter.default.addObserver(self, selector: #selector(self.catchNotificationFromFirebaseDataModel), name: .playersJoinedTheGameLabelHasBeenUpdated, object: nil)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Help", style: .done, target: self, action: #selector(helpTapped))
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //rest IndexOfSection
        IndexOfSection = 999
        //rest to false
        numberOfPlayersIsOne = false
        
        DispatchQueue.main.async (execute: { () -> Void in
            self.tableView.reloadData()
        })
    }
    
    
    
    @objc func catchNotificationFromFirebaseDataModel(notification: Notification) {
        
        if let dataModel = notification.object as? FirebaseDataModel {
           game = dataModel.data
            self.tableView.reloadData()
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
        header.backgroundView?.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        header.textLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (section) {
        case 0:

            return game.numberOfInnocent
                //game.innocentsGroup.count
        case 1:

            return game.numberOfMafia
                //game.mafiaGroup.count
            
        default:
            return game.numberOfOthers
                //game.othersGroup.count
        }
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "editRoleCell", for: indexPath)
        
//        let player = playerForCell(sectionIndex: indexPath.section, rowIndex: indexPath.row, game: game)
        
        let player = game.playerForCell(sectionIndex: indexPath.section, rowIndex: indexPath.row)
        
        cell.textLabel?.text = player.name
        cell.detailTextLabel?.text = player.role
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.numberOfRows(inSection: indexPath.section) == 1 && indexPath.section != 2 {
            IndexOfSection = indexPath.section
            numberOfPlayersIsOne = true
        }
        
        selectedPlayer = game.playerForCell(sectionIndex: indexPath.section, rowIndex: indexPath.row)
          //  playerForCell(sectionIndex: indexPath.section, rowIndex: indexPath.row, game: game)
        
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
            destinationVC?.IndexOfSection = IndexOfSection
            destinationVC?.numberOfPlayersIsOne = numberOfPlayersIsOne
        }
    }
}


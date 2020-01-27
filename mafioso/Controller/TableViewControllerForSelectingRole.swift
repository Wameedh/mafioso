//
//  PopUpTableViewControllerForSelectingRole.swift
//  mafioso
//
//  Created by Wameedh Mohammed Ali on 2/8/19.
//  Copyright © 2019 Wameedh Mohammed Ali. All rights reserved.
//

import UIKit
import Firebase

class TableViewControllerForSelectingRole: UITableViewController {
    
    lazy var ref = Database.database().reference().child("Games")
    var player: Player!
    var gameCode = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Roles Info", style: .done, target: self, action: #selector(rolesInfoTapped))
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // return the number of sections
        return 3
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // return the tiltes of sections
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
        // #warning Incomplete implementation, return the number of rows
        
        return RolesData.roles[section].count
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailsOfRolesCell", for: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = RolesData.roles[indexPath.section][indexPath.row]
        
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedRole = RolesData.roles[indexPath.section][indexPath.row]
        updateDBWithNewRole(role: selectedRole, groupNumber: indexPath.section + 1)
        
        if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        
    }
    //updates The Database With the New Role
    func updateDBWithNewRole(role: String, groupNumber: Int) {
        ref.child(gameCode + "/players/" + player.indexOfselectedPlayerInTheDB).updateChildValues([ "role": role, "group": groupNumber])
    }
    
    // MARK: - IBAction
    
    @IBAction func rolesInfoTapped(_ sender: Any){
        self.performSegue(withIdentifier: "fromSelectingRolesToHowToPlayDetails", sender: self)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "fromSelectingRolesToHowToPlayDetails" {
            let destinationVC = segue.destination as? HowToPlayDetailsVC
            
            destinationVC?.content = howToPlayData[3][1]
        }
    }
}

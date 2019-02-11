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
    //var selectedPlayerID: String = "XXX"
   // var indexOfselectedPlayerInTheDB: Int!
    //var arrayOfRoles: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //indexOfselectedPlayerInTheDB = try? game.getIndexOfselectedPlayerInTheDB(uid: selectedPlayerID)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Roles Info", style: .done, target: self, action: #selector(rolesInfoTapped))
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
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
        // #warning Incomplete implementation, return the number of rows
        
            return RolesData.roles[section].count

    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "slectingRoleCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = RolesData.roles[indexPath.section][indexPath.row]

        return cell
    }
 
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let x = RolesData.roles[indexPath.section][indexPath.row]
        updateDBWithNewRole(role: x)
        
    if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        
    }
    //updates The Database With the New Role
    func updateDBWithNewRole(role: String) {
        ref.child(gameCode + "/players/" + player.indexOfselectedPlayerInTheDB).updateChildValues([ "role": role])
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
    
    //updates The Game Locally With New Role
//    func updateTheGameLocallyWithNewRole(role: String)  {
//
//        game.players[]
//
//
//    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
   */
    
    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
   */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    

}

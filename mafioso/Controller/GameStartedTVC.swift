//
//  gameStartedTVC.swift
//  mafioso
//
//  Created by Wameedh Mohammed Ali on 1/22/19.
//  Copyright © 2019 Wameedh Mohammed Ali. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD
class GameStartedTVC: UITableViewController {
    
  
    var game: Game!
    var ref = Database.database().reference()
    
    var arrayOfBoolsForCellImage: [[Bool]] = [[],[],[]]
    
    @IBOutlet weak var endGameButton: UIButton!
    
    
    override func viewDidLoad() {
        
        SVProgressHUD.dismiss()
        setPositionEndGameButton()
        self.tableView.rowHeight = 70.0
        populateArrayOfUsersIds()
        print(arrayOfBoolsForCellImage)
        
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
            return game.innocentsGroup.count
        case 1:
            return game.mafiaGroup.count
        default:
            return game.othersGroup.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameStartedTVCCell", for: indexPath)
        
        let player = playerForCell(sectionIndex: indexPath.section, rowIndex: indexPath.row, game: game)
        
        if arrayOfBoolsForCellImage[indexPath.section][indexPath.row] {
            cell.imageView?.image = nil
        } else {
            cell.imageView?.image = UIImage(named: "rip")
        }
        
        
        cell.imageView?.frame.size.height = 60.0
        cell.imageView?.frame.size.width = 60.0
        
        cell.textLabel?.text = player.name
        cell.detailTextLabel?.text = player.role
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedPlayer: Player = playerForCell(sectionIndex: indexPath.section, rowIndex: indexPath.row, game: game)
        
    presentAlert(title: "Do you want to kill this player?", message: nil, vc: self, action: UIAlertAction(title: "Yes", style: .destructive, handler: { (_) in
            self.ref.child("Games").child(self.game.gameCode + "/players/" + selectedPlayer.indexOfselectedPlayerInTheDB).updateChildValues([ "status": false])
        
        self.arrayOfBoolsForCellImage[indexPath.section][indexPath.row] = false
        self.tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
        }), cancelAction: UIAlertAction(title: "No", style: .cancel, handler: { (_) in
            self.tableView.deselectRow(at: indexPath, animated: true)
        }))
       
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


    func populateArrayOfUsersIds() {
        
        for player in game.players {
            if player.group == 1 {
                //innocent
                arrayOfBoolsForCellImage[0].append(player.status)
            } else if player.group == 2 {
                //mafia
                arrayOfBoolsForCellImage[1].append(player.status)
            } else {
                //others
                arrayOfBoolsForCellImage[2].append(player.status)
            }
        }
    }
    
     // MARK: - IBAction
    @IBAction func endGameButtonPressed(_ sender: Any) {
        
        presentAlert(title: "Are you sure you want to quit?", message: "That means you will terminate your role in the game",vc: self, action:
            UIAlertAction(title: "Yes", style: .destructive, handler: { (_) in
            self.performSegue(withIdentifier: "unwindToNewJoinGame", sender: self)
           
                //It could be improved, maybe using the removeGameAndUser function from the dataModel class!
                for i in self.game.arrayOfUsersIds {
                    self.ref.child("Users").child(i).removeValue()
                }
                if let uid = Auth.auth().currentUser?.uid {
                self.ref.child("Users").child(uid).removeValue()
                }
            self.ref.child("Games").child(self.game.gameCode).removeValue()
                
                }), cancelAction: nil)
    }
    
}

//
//  InGame.swift
//  mafioso
//
//  Created by Wameedh Mohammed Ali on 1/19/19.
//  Copyright © 2019 Wameedh Mohammed Ali. All rights reserved.
//

import UIKit
import Firebase

class InGameVC: UIViewController {
    
    
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var descriptionOfRoleLabel: UILabel!
    @IBOutlet weak var roleHeaderLabel: UILabel!
    
    let ref = Database.database().reference()
    var player: Player!
    var role = ""
    var labelsStatus: Bool = false
    var gameCode: String!
    
    override func viewDidLoad() {
        role = player.role
        //notification: OLD WAT
    NotificationCenter.default.addObserver(self, selector: #selector(catchNotificationFromWelcomeVC), name: .userIsAlreadyInAGame, object: nil)
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
        self.roleLabel.text = self.role
        self.updateLabelsStatus()
        }
      //  roleLabel.text = role
        
    }
    
    //updateLablesAfterNotified
    @objc func catchNotificationFromWelcomeVC(notification: Notification) {
        
        if let player = notification.object as? Player {
        role = player.role
        } else if let status = notification.object as? Bool {
            labelsStatus = status
            updateLabelsStatus()
        }
        
    }
    
    func updateLabelsStatus(){
        
        if labelsStatus {
            descriptionOfRoleLabel.text = waitingMessage.randomElement()
            descriptionOfRoleLabel.textAlignment = .center
            descriptionOfRoleLabel.font = descriptionOfRoleLabel.font.withSize(24)
        } else {
            descriptionOfRoleLabel.text = RolesData.description[role]
            descriptionOfRoleLabel.textAlignment = .left
            descriptionOfRoleLabel.font = descriptionOfRoleLabel.font.withSize(19)
            
        }
        roleLabel.isHidden = labelsStatus
        roleHeaderLabel.isHidden = labelsStatus
        //descriptionOfRoleLabel.isEnabled = labelsStatus
    }
    
    //TO DO: delete the player from the game
    
    @IBAction func quitPressed(_ sender: Any) {
//       presentAlert(title: "Are you sure you want to quit?", message: "That means you will terminate your role in the game", vc: self)
        
        presentAlert(title: "Are you sure you want to quit?", message: "That means you will terminate your role in the game", vc: self, action: UIAlertAction(title: "Yes", style: .destructive, handler: { (_) in
            self.performSegue(withIdentifier: "unwindToNewJoinGame", sender: self)
            guard let uid = Auth.auth().currentUser?.uid else {
                return
            }
        Database.database().reference().child("Users").child(uid).removeValue()
            
        Database.database().reference().child("Games").child(self.gameCode + "/players/" + self.player.indexOfselectedPlayerInTheDB).updateChildValues(["id": "000000", "name": "Player has left the game"])
        }))
       
    }
   
}

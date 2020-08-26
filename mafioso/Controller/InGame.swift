//
//  InGame.swift
//  mafioso
//
//  Created by Wameedh Mohammed Ali on 1/19/19.
//  Copyright © 2019 Wameedh Mohammed Ali. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class InGameVC: UIViewController {
    
    // MARK: - IBOUTLETS
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var descriptionOfRoleLabel: UILabel!
    @IBOutlet weak var roleHeaderLabel: UILabel!
    
    // MARK: - VARIABLES
    let ref = Database.database().reference()
    var player: Player!
    var role = ""
    var gameCode: String!
    var game: Game!
    var counter = 0
    
    
    // MARK: - OVERRIDE FUNCTIONS
    override func viewDidLoad() {
        SVProgressHUD.dismiss()
        updateDescriptionOfRoleLabel(labelsStatus: false)
        //notification: OLD WAY
        NotificationCenter.default.addObserver(self, selector: #selector(catchNotificationFromWelcomeVC), name: .notifyUsersInGame, object: nil)
        
    }
    
    // MARK: - NOTIFICATIONS
    //updateLablesAfterNotified
    @objc func catchNotificationFromWelcomeVC(notification: Notification) {
        
        if let notificationObject = notification.object as? [String: AnyObject] {
            //if the notification comea from VCSwitcher which means the user has termenated the game and came back
            gameCode = (notificationObject["gameCode"] as! String)
            player = (notificationObject["player"] as! Player)
            role = player.role
            let gameStarted = (notificationObject["gameStarted"] as! Bool)
            if player.status {
                updateLabelsStatus(labelsStatus: gameStarted)
                updateDescriptionOfRoleLabel(labelsStatus: gameStarted)
            } else if !player.status {
                updatedescriptionOfRoleLabelWhenPlayerIsDead()
            }
        } else if let data = notification.object as? Game {
            //if the notification has been sent from the PlayVC which means the modertaor has started the game
            do {
                player = try data.getCurrentPlayer()
                if (data.gameStarted) && player.status {
                    // player = try data.getCurrentPlayer()
                    self.role = player.role
                    updateLabelsStatus(labelsStatus: data.gameStarted)
                    updateDescriptionOfRoleLabel(labelsStatus: data.gameStarted)
                    //counter = 1
                    
                } else {
                    print(data)
                    // player = try? data.getCurrentPlayer()
                    if !player.status {
                        updatedescriptionOfRoleLabelWhenPlayerIsDead()
                    }
                }
            } catch {
                print(error)
            }
        }
    }
    
    // MARK: - LABELS FUNCTIONS
    func updateDescriptionOfRoleLabel(labelsStatus: Bool){
        if labelsStatus {
            // Get the role of player
            roleLabel.text = role
            // Update and formate description label
            descriptionOfRoleLabel.text = RolesData.description[role]
            descriptionOfRoleLabel.textAlignment = .left
            descriptionOfRoleLabel.font = descriptionOfRoleLabel.font.withSize(19)
            descriptionOfRoleLabel.textColor = .black
            
        } else {
            // Update and formate description label
            descriptionOfRoleLabel.text = waitingMessage.randomElement()
            descriptionOfRoleLabel.textAlignment = .center
            descriptionOfRoleLabel.font = descriptionOfRoleLabel.font.withSize(24)
            descriptionOfRoleLabel.textColor = .black
        }
    }
    
    func updatedescriptionOfRoleLabelWhenPlayerIsDead(){
        // hid lables
        updateLabelsStatus(labelsStatus: false)
        // Update and formate description label
        descriptionOfRoleLabel.text = "You have been killed"
        descriptionOfRoleLabel.textAlignment = .center
        descriptionOfRoleLabel.font = descriptionOfRoleLabel.font.withSize(24)
        descriptionOfRoleLabel.textColor = .red
    }
    
    
    func updateLabelsStatus(labelsStatus: Bool){
        // True hid the labels , False show the labels
        roleLabel.isHidden = !labelsStatus
        roleHeaderLabel.isHidden = !labelsStatus
    }
    
    // MARK: - QUITING THE GAME FUNCTIONS
    func quitGameAndLeaveDB() {
        ref.child("Games").child(gameCode).observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists() {
                self.ref.child("Games").child(self.gameCode + "/players/" + self.player.indexOfselectedPlayerInTheDB).updateChildValues(["id": "000000", "name": "Player has left the game", "status": false])
            }
        })
    }
    // MARK: - IBAction
    @IBAction func quitPressed(_ sender: Any) {
        //       presentAlert(title: "Are you sure you want to quit?", message: "That means you will terminate your role in the game", vc: self)
        presentAlert(title: "Are you sure you want to quit?", message: "That means you will terminate your role in the game", vc: self, action: UIAlertAction(title: "Yes", style: .destructive, handler: { (_) in
            self.performSegue(withIdentifier: "unwindToNewJoinGame", sender: self)
            guard let uid = Auth.auth().currentUser?.uid else {
                return
            }
            self.ref.child("Users").child(uid).removeValue()
            self.quitGameAndLeaveDB()
        }), cancelAction: nil)
    }
}

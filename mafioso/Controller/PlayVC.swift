//
//  PlayVC.swift
//  mafioso
//
//  Created by Wameedh Mohammed Ali on 12/29/18.
//  Copyright © 2018 Wameedh Mohammed Ali. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class PlayVC: UIViewController {

    @IBOutlet weak var editRolesButton: UIButton!
    @IBOutlet weak var gameCodeLable: UILabel!
    @IBOutlet weak var informationForstartingGameLabel: UILabel!
    @IBOutlet weak  var playersJoinedLable: UILabel!
    
    var ref = Database.database().reference()
    var gameCode = ""
    var dataModel: FirebaseDataModel!
    var numberOfPlayers = 0

    
    
    override func viewDidLoad() {
        SVProgressHUD.dismiss()
        gameCodeLable.text = gameCode
        dataModel = FirebaseDataModel(childPath: gameCode)
    NotificationCenter.default.addObserver(self, selector: #selector(updateplayersJoinedLableAfterNotified), name: .playersJoinedTheGameLabelHasBeenUpdated, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingFromParent {
            for i in self.dataModel.data.arrayOfUsersIds {
                ref.child("Users").child(i).removeValue()
            }
            ref.child("Games").child(self.gameCode).removeValue()
        }
    }
    
   //Update the playersJoinedLable
    func updateLabel() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
        self.playersJoinedLable.text = String(self.dataModel.data.playersJoined)
        }
    }
    
    //update playersJoinedLable After Notified from the data model that the value has changed, or one or more players has joined
    @objc func updateplayersJoinedLableAfterNotified() {
        updateLabel()
    }
    
    
    // MARK: - IBAction
    @IBAction func editRoleButtonPressed(_ sender: Any) {
        if dataModel.data.playersJoined == numberOfPlayers {
            performSegue(withIdentifier: "editRolesTVC", sender: self)
        } else {
            informationForstartingGameLabel.text = "Wait for all players to join!"
        }
    }
    
    
    @IBAction func startbuttonPressed(_ sender: Any) {
        if dataModel.data.playersJoined == numberOfPlayers {
           ShowCustomSVProgressHUD()
            performSegue(withIdentifier: "gameStartedTVC", sender: self)
    ref.child("Games").child(gameCode).updateChildValues(["gameStarted": true])
        if let uid = Auth.auth().currentUser?.uid  {
                ref.child("Users").child(uid).setValue(["moderator": gameCode])
            }
        } else {
            informationForstartingGameLabel.text = "Wait for all players to join!"
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gameStartedTVC"{
            let destinationVC = segue.destination as? GameStartedTVC
            
            destinationVC?.game = dataModel.data
        }
        if segue.identifier == "editRolesTVC" {
            let destinationVC = segue.destination as? EditRolesTableVC
            
            destinationVC?.game = dataModel.data
        }
    }
}

    
    
    







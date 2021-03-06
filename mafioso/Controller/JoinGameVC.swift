//
//  JoinGameVC.swift
//  mafioso
//
//  Created by Wameedh Mohammed Ali on 12/24/18.
//  Copyright © 2018 Wameedh Mohammed Ali. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class JoinGameVC: UIViewController, UITextFieldDelegate {
    // MARK: - IBOUTLETS
    @IBOutlet weak var gameCodeTextField: UITextField!
    @IBOutlet weak var ErrorLable: UILabel!
    
    // MARK: - VARIABLES
    lazy var ref = Database.database().reference()
    private var dataModel: FirebaseDataModel!
    var player: Player = Player()
    var counter = 0
    
    // MARK: - OVERRIDE FUNCTIONS
    override func viewDidLoad() {
        gameCodeTextField.delegate = self
    }
    
    func playerJoinedInDatabase(gamecode: String) {
        if dataModel.dataModeled == true {
            //chaned to let check after testing
            let playersArray = dataModel.data.players
            let numberOfPlayersInGame = dataModel.data.playersJoined
            
            for i in 0..<playersArray.count {
                //NOTE//updtat the for loop to exit as soon as it assign the player
                if playersArray[i].uid == "none" && counter == 0 {
                    player = playersArray[i]
                    
                    guard let id = Auth.auth().currentUser?.uid else {
                        return
                    }
                    guard let name = Auth.auth().currentUser?.displayName else {
                        return
                    }
                    guard let uid = Auth.auth().currentUser?.uid else {
                        return
                    }
                    //Sets the game gode that user is part of in the reltime database. The user node contain childs, each child has its tile as the user id.
                    ref.child("Users").child(uid).setValue(["gameCode": gamecode])
                    ref.child("Games").child(gamecode + "/players/" + String(i)).updateChildValues(["id": id, "name": name])
                    ref.child("Games").child(gamecode).updateChildValues(["playersJoined": numberOfPlayersInGame + 1])
                    
                    counter = 1
                } else {
                    ErrorLable.text =  "Sorry, the game is full"
                }
            }
        }
    }
    
    // MARK: - FUNCTIONS
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        textField.resignFirstResponder()  //if desired
        ShowCustomSVProgressHUD()
        joinGame()
        return true
    }
    
    
    func naveToInGameVC() {
        if player.role != "" {
            performSegue(withIdentifier: "inGame", sender: self)
            counter = 0
            player = Player()
        } else {
            ErrorLable.isHidden = false
            SVProgressHUD.dismiss()
        }
    }
    
    func joinGame()  {
        if let gamecode = gameCodeTextField.text?.uppercased(), gamecode != "", counter == 0 {
            dataModel = FirebaseDataModel(childPath: gamecode)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                // Code will be delayed by 0.5 seconds to make sure that FirebaseDataModel has initialized the data, and that the data is ready to be used
                self.playerJoinedInDatabase(gamecode: gamecode)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
              self.naveToInGameVC()
            }
        } else {
            ErrorLable.isHidden = false
            SVProgressHUD.dismiss()
        }
    }
    
    @IBAction func joinPressed(_ sender: Any) {
        ShowCustomSVProgressHUD()
        joinGame()
    }
    // MARK: - NAVIGATIONS
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "inGame" {
            let destinationVC = segue.destination as? InGameVC
            
            destinationVC?.gameCode = dataModel.data.gameCode
            destinationVC?.player = player
            
        }
        
    }
}

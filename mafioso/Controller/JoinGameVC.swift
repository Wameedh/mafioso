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

class JoinGameVC: UIViewController {
    
    lazy var functions = Functions.functions()
    
    lazy var ref = Database.database().reference()
    
    private var dataModel: FirebaseDataModel!
    
    @IBOutlet weak var gameCodeTextField: UITextField!
   
    @IBOutlet weak var ErrorLable: UILabel!
    
   
    
    var player: Player = Player()
    var counter = 0
   
    
    
    override func viewDidLoad() {
        
        
    }
    
    
    
  
    func playerJoinedInDatabase(gamecode: String) {
        if dataModel.dataModeled == true {
            
            var playersArray = dataModel.data.players
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
                
                ref.child(gamecode + "/players/" + String(i)).updateChildValues(["id": id, "name": name])
                ref.child(gamecode).updateChildValues(["playersJoined": numberOfPlayersInGame + 1])
                
                counter = 1
            } else {
                ErrorLable.text =  "Sorry, the game is full"
                }
            }
        }
    }
  
    
    
    @IBAction func joinPressed(_ sender: Any) {
        
         SVProgressHUD.show()
        
    if let gamecode = gameCodeTextField.text?.uppercased(), gamecode != "", counter == 0 {
        
            dataModel = FirebaseDataModel(childPath: gamecode)
            
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
    // Code will be delayed by 0.5 seconds to make sure that FirebaseDataModel has initialized the data, and that the data is ready to be used
        self.playerJoinedInDatabase(gamecode: gamecode)
            }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if self.player.role != "" {
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: "inGame", sender: self)
                self.counter = 0
                self.player = Player()
            } else {
               self.ErrorLable.isHidden = false
                SVProgressHUD.dismiss()
            }
        }
        
        
        
        } else {
            ErrorLable.isHidden = false
            SVProgressHUD.dismiss()
        }
        
        
        
    
        
 }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "inGame" {
            let destinationVC = segue.destination as? InGameVC
            
          destinationVC?.role = player.role

    }
    
    }
}

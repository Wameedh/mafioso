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
//    var dataModel: Game!
    
    let ref = Database.database().reference()
    
    private var dataModel: FirebaseDataModel!
    
    @IBOutlet weak var gameCodeTextField: UITextField!
    
    @IBOutlet weak var nickNameTextField: UITextField!
    
    //reference to the Data Model Class
    
    
    override func viewDidLoad() {
        

        
    }
    
    
    func playerJoinedInDatabase(gamecode: String) {
        var playersArray = dataModel.data.players
        var counter = 0
        for i in 0..<playersArray.count {
            //NOTE//updtat the for loop to exit as soon as it assign the player
            if playersArray[i].uid == "none" && counter == 0 {
                ref.child(gamecode + "/players/" + String(i)).updateChildValues(["id": "123"])
                counter += 1
            }
        }
        
    }
   
  
    @IBAction func joinPressed(_ sender: Any) {
         SVProgressHUD.show()
          var y = ""
        if let gamecode = gameCodeTextField.text, gamecode != "" {
           dataModel = FirebaseDataModel(childPath: gamecode)
            y = gamecode
        }
        
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
    // Code will be delayed by 0.5 seconds to make sure that FirebaseDataModel has initialized the data, and that the data is ready to be used
            
            self.playerJoinedInDatabase(gamecode: y)
            //TEST
            if let x = self.dataModel.data{
            print("Game Code: \(x.gameCode)")
            print(x.players[0].role)
            print(x.toAnyObject())
            }
            SVProgressHUD.dismiss()
        }
        
 }
    
    
    
    
    
}

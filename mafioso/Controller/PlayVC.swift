//
//  PlayVC.swift
//  mafioso
//
//  Created by Wameedh Mohammed Ali on 12/29/18.
//  Copyright © 2018 Wameedh Mohammed Ali. All rights reserved.
//

import UIKit

class PlayVC: UIViewController {

    @IBOutlet weak var editRolesButton: UIButton!
    
    @IBOutlet weak var gameCodeLable: UILabel!
    
    @IBOutlet weak  var playersJoinedLable: UILabel!
    
    lazy var gameCode = ""
    var dataModel: FirebaseDataModel!
    var numberOfPlayers = 0

    
    
    override func viewDidLoad() {
        gameCodeLable.text = gameCode
        dataModel = FirebaseDataModel(childPath: gameCode)
    NotificationCenter.default.addObserver(self, selector: #selector(updateplayersJoinedLableAfterNotified), name: .playersJoinedTheGameLabelHasBeenUpdated, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        NotificationCenter.default.removeObserver(self)
    }
    
    
   //Update the playersJoinedLable
    func updateLabel() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
        self.playersJoinedLable.text = String(self.dataModel.data.playersJoined)
        if self.dataModel.data.playersJoined == self.numberOfPlayers {
            self.editRolesButton.isHidden = false
        }
        }
    }
    
    //update playersJoinedLable After Notified from the data model that the value has changed, or one or more players has joined
    @objc func updateplayersJoinedLableAfterNotified() {
        updateLabel()
        
    }
    
    
    
    @IBAction func editRoleButtonPressed(_ sender: Any) {
        
        if dataModel.data.playersJoined == numberOfPlayers {
            print("passed")
            performSegue(withIdentifier: "editRolesTVC", sender: self)
            
        }
        
    }
    
    
    //TO-DO: Start the game action. This should happen after all players has joined.
    
    @IBAction func startbuttonPressed(_ sender: Any) {
        
        if dataModel.data.playersJoined == numberOfPlayers {
            performSegue(withIdentifier: "gameStartedTVC", sender: self)
            NotificationCenter.default.post(name: .userIsAlreadyInAGame, object: true)
        }
    }
    
    
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

    
    
    







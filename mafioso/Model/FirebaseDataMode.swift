//
//  FirebaseDataMode.swift
//  mafioso
//
//  Created by Wameedh Mohammed Ali on 1/6/19.
//  Copyright © 2019 Wameedh Mohammed Ali. All rights reserved.
//

import UIKit
import Firebase

class FirebaseDataModel: NSObject {
    
    var dataModeled = false
    var childPath: String
    var data: Game!
    
    let ref = Database.database().reference()
   // var error: appErrors!
    
    init(childPath: String) {
        self.childPath = childPath
        super.init()
        self.observer()
    }
    
    func snap(snapshot: DataSnapshot) {
        
        var playersArray = [Player]()
        
        if let value = snapshot.value as? [String: AnyObject],let playersJoined = value["playersJoined"] as? Int,
            let gameCode = value["gameCode"] as? String,
            let players = value["players"] as? [AnyObject],let gameStarted = value["gameStarted"] as? Bool {
            
            //Modling array of players that will be used for initilaizing
            
            //loops over the players in the gamep
            for i in 0..<players.count {
                if let status = players[i]["status"] as? Bool, let role = players[i]["role"] as? String, let name = players[i]["name"] as? String, let id = players[i]["id"] as? String, let group = players[i]["group"] as? Int
                {
                    var player: Player = Player()
                    player.name = name
                    player.role = role
                    player.status = status
                    player.uid = id
                    player.group = group
                    player.indexOfselectedPlayerInTheDB = String(i)
                    playersArray.append(player)
                }
            }
            self.data = Game(gameCode: gameCode, gameStarted: gameStarted, players: playersArray, playersJoined: playersJoined)
            NotificationCenter.default.post(name: .playersJoinedTheGameLabelHasBeenUpdated, object: self)
            
            NotificationCenter.default.post(name: .notifyUsersInGame, object: self.data)
            dataModeled = true
        } else {
            print("Data has not been modeled!")
        }
    }
    
    func observer() {
        Database.database().reference().child("Games").child(childPath).observe(.value) { (snapshot) in
            self.snap(snapshot: snapshot)
            //print("updated")
            
        }
    }
    
    //Remove game and user
    func removeGameAndUser(gameCode: String){
        //Delete the players' IDs from the user ID node
        for i in data.arrayOfUsersIds {
                     ref.child("Users").child(i).removeValue()
                          }
                //Delete the moderator ID from the user ID node
                if let uid = Auth.auth().currentUser?.uid {
        ref.child("Users").child(uid).removeValue()
                }
              //Delete the game
            ref.child("Games").child(gameCode).removeValue()
    }
}




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
   
    var error: appErrors!

    init(childPath: String) {
        self.childPath = childPath
        super.init()
        self.observer()
    }
    
    
    func snap(snapshot: DataSnapshot) {
    
     var playersArray = [Player]()
    
        if let value = snapshot.value as? [String: AnyObject],let playersJoined = value["playersJoined"] as? Int,
            let gameCode = value["gameCode"] as? String,
            let players = value["players"] as? [AnyObject] {
            //Modling array of players that will be used for initilaizing
            
            //loops over the players in the gamep
            for i in 0..<players.count {
                if let status = players[i]["status"] as? String, let role = players[i]["role"] as? String, let name = players[i]["name"] as? String, let id = players[i]["id"] as? String, let group = players[i]["group"] as? Int
                {
                    print("MashaAllah")
                    
                    var player: Player = Player()
                    player.name = name
                    player.role = role
                    player.status = status.boolValueFromString()
                    player.uid = id
                    player.group = group
                    player.indexOfselectedPlayerInTheDB = String(i)
                    playersArray.append(player)
                }
            }
            self.data = Game(gameCode: gameCode, player: playersArray, playersJoined: playersJoined)
            
        NotificationCenter.default.post(name: .playersJoinedTheGameLabelHasBeenUpdated, object: self)
            dataModeled = true
        } else {
            print("Data has not been modeled!")
        }
        
    }

    
    func observer() {
        Database.database().reference().child("Games").child(childPath).observe(.value) { (snapshot) in
            self.snap(snapshot: snapshot)
            print("updated")
            
        }
    }

//func addGame(game: Game){
//        data = game
//        firebaseReference.child(childPath).setValue(game)
//    }

    
//func deleteGame(game: Game){
//        //1
//        if data.gameCode == game.gameCode {
//            data = [Game]
//        }
//
//        //2
//    firebaseReference.child(childPath).observeSingleEvent(of: DataEventType.value, with: {
//            (snapshot) in
//            //3
//            let children = snapshot.children
//            while let child = children.nextObject() as? DataSnapshot {
//                if item == child.value as! String {
//                    //4
//                    child.ref.removeValue()
//
//
//                    //5
//                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refresh"), object: nil)
//                    break
//                }
//            }
//        }, withCancel: nil)
//    }

}




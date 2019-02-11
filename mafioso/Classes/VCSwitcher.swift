////
////  VCSwitcher.swift
////  mafioso
////
////  Created by Wameedh Mohammed Ali on 1/3/19.
////  Copyright © 2019 Wameedh Mohammed Ali. All rights reserved.
////
//
import UIKit
import Firebase

class VCSwitcher {
    
    static func updateRootVC(){
        
        let status = Auth.auth().currentUser
        var rootVC : UIViewController
        
        
        if(status != nil){
            rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "newJoinGame") as! UINavigationController
        }else{
            rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "welcomeVC") as! WelcomeVC
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = rootVC
        
    }
    
    
    
    private static func getCurrentPlayer(dataModel: FirebaseDataModel) -> Player {
        var playersArray = dataModel.data.players
        var player: Player = Player()
        for i in 0..<playersArray.count {
            //NOTE//updtat the for loop to exit as soon as it assign the player
            if playersArray[i].uid == Auth.auth().currentUser?.uid {
                player = playersArray[i]
                print(player)
                break
            }
        }
        
            return player
    }
    
    
    //If there is a logged in user, by pass this screen and go straight to new/join a game ViewController
    
   class func checkIfUserIsPartOfAGame(rootViewController: UIViewController) {
        
        let userID = Auth.auth().currentUser?.uid
        let userIDNode = Database.database().reference().child("Users")
        
        
        userIDNode.child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            
            if snapshot.exists() {
                guard let value = snapshot.value as? [String: AnyObject] else {
                    return
                }
                if let gameCode = value["gameCode"] as? String {
                    
                    let dataModel = FirebaseDataModel(childPath: gameCode)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        let player = getCurrentPlayer(dataModel: dataModel)
                        
                        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "786") as! InGameVC
                        
                rootViewController.present(vc, animated: true, completion: nil)
                NotificationCenter.default.post(name: .userIsAlreadyInAGame, object: player)
                    }
                }
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    
    
    
}

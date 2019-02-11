//
//  WelcomeVC.swift
//  mafioso
//
//  Created by Wameedh Mohammed Ali on 1/1/19.
//  Copyright © 2019 Wameedh Mohammed Ali. All rights reserved.
//

import UIKit
import Firebase


class WelcomeVC: UIViewController {
    private var dataModel: FirebaseDataModel!
    var player: Player = Player()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TO DO make a label in the welcomeVC that will notify the user (God willing) when there is not internet conection.
        if Auth.auth().currentUser == nil {
         print("Internet Conection error")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    @IBAction func unwindToNewJoinGameView(segue: UIStoryboardSegue) {
        
        if let segue = segue as? UIStoryboardSegueWithCompletion {
            segue.completion = {
                self.performSegue(withIdentifier: "newJoinAGameVC", sender: self)
            }
        }
        
    }
   
    
//    let userID = Auth.auth().currentUser?.uid
//    Database.database().reference().child("Users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
//    // Get user value
//    guard let value = snapshot.value as? [String: AnyObject] else {
//    return
//    }
//    guard let gameCode = value["gameCode"] as? String else {
//    return
//    }
//
//    self.dataModel = FirebaseDataModel(childPath: gameCode)
//    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//    self.x()
//
//
//    }
//    }) { (error) in
//    //                self.performSegue(withIdentifier: "newJoinAGameVC", sender: self)
//    print(error.localizedDescription)
//    }
//
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        if segue.identifier == "toInGame"{
//        if let vc = segue.destination as? InGameVC {
//            vc.role = "MashaAllah"
//        }
//     }
//    }
    
}

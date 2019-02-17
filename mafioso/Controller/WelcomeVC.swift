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
}

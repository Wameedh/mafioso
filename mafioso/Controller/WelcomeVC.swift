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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //If there is a logged in user, by pass this screen and go straight to ChatViewController
        
        if Auth.auth().currentUser != nil {
            performSegue(withIdentifier: "goToChat", sender: self)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

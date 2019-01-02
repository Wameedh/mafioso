//
//  JoinGameVC.swift
//  mafioso
//
//  Created by Wameedh Mohammed Ali on 12/24/18.
//  Copyright © 2018 Wameedh Mohammed Ali. All rights reserved.
//

import UIKit
import Firebase

class JoinGameVC: UIViewController {
    
    @IBOutlet weak var gameCodeTextField: UITextField!
    
    @IBOutlet weak var nickNameTextField: UITextField!
    
    
    override func viewDidLoad() {
        
    }
    
    
    @IBAction func joinPressed(_ sender: Any) {
        
        let gameDB = Database.database().reference().child(gameCodeTextField.text!)
        
        gameDB.childByAutoId().setValue(nickNameTextField.text!)
        
        
    }
    
    
    
}

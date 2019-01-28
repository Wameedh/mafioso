//
//  InGame.swift
//  mafioso
//
//  Created by Wameedh Mohammed Ali on 1/19/19.
//  Copyright © 2019 Wameedh Mohammed Ali. All rights reserved.
//

import UIKit

class InGameVC: UIViewController {
    

    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var descriptionOfRoleLabel: UILabel!
    
    var role = ""
    
    override func viewDidLoad() {
        
        roleLabel.text = role
        roleLabel.highlightedTextColor = UIColor.red
        descriptionOfRoleLabel.text = RolesData.getDescriptionOfARole(role: role)
        
    }
    
    
    @IBAction func quitPressed(_ sender: Any) {
       presentAlert(title: "Are you sure you want to quit?", message: "That means you will terminate your role in the game", vc: self)
        
    }
    
    
    
    
}

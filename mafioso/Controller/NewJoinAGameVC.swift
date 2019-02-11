//
//  ViewController.swift
//  mafioso
//
//  Created by Wameedh Mohammed Ali on 9/27/18.
//  Copyright © 2018 Wameedh Mohammed Ali. All rights reserved.
//

import UIKit
import Firebase

class NewJoinAGameVC: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        VCSwitcher.checkIfUserIsPartOfAGame(rootViewController: self)
        RolesData.observer()
    }
    
    
    
    @IBAction func unwindToNewJoinGameView(segue: UIStoryboardSegue) {}

    
    
    
    @IBAction func newGamePressed(_ sender: Any) {
        performSegue(withIdentifier: "numberofPlayerVC", sender: self)
    }
    
    

}


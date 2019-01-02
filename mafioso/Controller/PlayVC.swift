//
//  PlayVC.swift
//  mafioso
//
//  Created by Wameedh Mohammed Ali on 12/29/18.
//  Copyright © 2018 Wameedh Mohammed Ali. All rights reserved.
//

import UIKit

class PlayVC: UIViewController {

    
    @IBOutlet weak var gameCodeLable: UILabel!
    
    @IBOutlet weak var playersJoinedLable: UILabel!
    
    var gameCode = ""
    
    override func viewDidLoad() {
        gameCodeLable.text = gameCode
    }
    
}

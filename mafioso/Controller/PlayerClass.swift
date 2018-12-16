//
//  PlayerClass.swift
//  mafioso
//
//  Created by Wameedh Mohammed Ali on 10/31/18.
//  Copyright © 2018 Wameedh Mohammed Ali. All rights reserved.
//

import UIKit

class Player {
    
    var playerName: String
    var title: String
    var status: Bool
    
    init(playerName: String, title: String, status: Bool){
        self.playerName = playerName
        self.title = title
        self.status = status
    }
}


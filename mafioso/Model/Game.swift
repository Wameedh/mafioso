//
//  Game.swift
//  mafioso
//
//  Created by Wameedh Mohammed Ali on 1/5/19.
//  Copyright © 2019 Wameedh Mohammed Ali. All rights reserved.
//

import UIKit
import Firebase


protocol FirebaseModel {
    //init?(snapshot: DataSnapshot)
    func toAnyObject() -> [String: Any]
    
}


struct Game: FirebaseModel {
    
    
    var players: [Player]
    var gameCode: String
    
    
    init(gameCode: String, player: [Player]) {
        self.players = player
        self.gameCode = gameCode
    }
    func toAnyObject() -> [String: Any] {
        return [
            "gameCode": gameCode,
            "players": players
        ]
    }
    
    
    
    
}

//
//  Game.swift
//  mafioso
//
//  Created by Wameedh Mohammed Ali on 1/5/19.
//  Copyright © 2019 Wameedh Mohammed Ali. All rights reserved.
//

import UIKit
import Firebase

let myNotificationKey = "playersJoinedTheGameHasBeenUpdated"

protocol FirebaseModel {
    //init?(snapshot: DataSnapshot)
    func toAnyObject() -> [String: Any]
    
}


class Game {
    
    
    var players: [Player]
    var gameCode: String
    var playersJoined: Int
    
    var innocentsGroup: [Player] = []
    var mafiaGroup: [Player] = []
    var othersGroup: [Player] = []

    init(gameCode: String, player: [Player], playersJoined: Int) {
        self.players = player
        self.gameCode = gameCode
        self.playersJoined = playersJoined
        sortingPlayersInThreeGroups()
    }
    
    
    private func sortingPlayersInThreeGroups() {
        for player in players {
            if player.group == 1 {
                innocentsGroup.append(player)
            } else if player.group == 2 {
                mafiaGroup.append(player)
            } else {
                 othersGroup.append(player)
            }
        }
    }
    
    func toAnyObject() -> [String: Any] {
        return [
            "gameCode": gameCode,
            "players": players,
            "playersJoined": playersJoined
        ]
    }
    
    
    
    
}

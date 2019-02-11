//
//  Game.swift
//  mafioso
//
//  Created by Wameedh Mohammed Ali on 1/5/19.
//  Copyright © 2019 Wameedh Mohammed Ali. All rights reserved.
//

import UIKit
//protocol FirebaseModel {
//    //init?(snapshot: DataSnapshot)
//    func toAnyObject() -> [String: Any]
//
//}
class Game {
    
    
    var players: [Player]
    var gameCode: String
    var playersJoined: Int
    
    var numberOfInnocent: Int = 0
    var numberOfMafia: Int = 0
    var numberOfOthers: Int = 0
    
    
    
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
                numberOfInnocent += 1
            } else if player.group == 2 {
                mafiaGroup.append(player)
                numberOfMafia += 1
            } else {
                 othersGroup.append(player)
                numberOfOthers += 1
            }
        }
    }
    
//    func getIndexOfselectedPlayerInTheDB(uid: String) throws -> Int {
//        var index: Int!
//
//        for i in 0..<players.count {
//            if players[i].uid == uid {
//                index = i
//            }
//        }
//
//            return index
//
//    }
    
    func toAnyObject() -> [String: Any] {
        return [
            "gameCode": gameCode,
            "players": players,
            "playersJoined": playersJoined
        ]
    }
    
    
    
    
}

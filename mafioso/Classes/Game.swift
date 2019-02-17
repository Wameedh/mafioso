//
//  Game.swift
//  mafioso
//
//  Created by Wameedh Mohammed Ali on 1/5/19.
//  Copyright © 2019 Wameedh Mohammed Ali. All rights reserved.
//

import UIKit
import Firebase

class Game {
    
    
    var players: [Player]
    var gameCode: String
    var playersJoined: Int
    var gameStarted: Bool
    
    var numberOfInnocent: Int = 0
    var numberOfMafia: Int = 0
    var numberOfOthers: Int = 0
    //This array will be used to kick off all users from the game after the moderator termnate the game
    var arrayOfUsersIds: [String] = []
    
    
    var innocentsGroup: [Player] = []
    var mafiaGroup: [Player] = []
    var othersGroup: [Player] = []

    init(gameCode: String, gameStarted: Bool, player: [Player], playersJoined: Int) {
        self.players = player
        self.gameCode = gameCode
        self.playersJoined = playersJoined
        self.gameStarted = gameStarted
        sortingPlayersInThreeGroups()
        populateArrayOfUsersIds()
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
    
    
    func getCurrentPlayer() throws -> Player {
        
        var player: Player = Player()
        for i in 0..<players.count {
            //NOTE//updtat the for loop to exit as soon as it assign the player
            if players[i].uid == Auth.auth().currentUser?.uid {
                player = players[i]
                break
            }
        }
        
        return player
    }
    
    
    //Populate the ArrayOfUsersIds with the ids of all users in the game
    private func populateArrayOfUsersIds(){
        for i in players {
            arrayOfUsersIds.append(i.uid)
        }
    }
    
}

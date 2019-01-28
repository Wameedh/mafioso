//
//  PlayerClass.swift
//  mafioso
//
//  Created by Wameedh Mohammed Ali on 10/31/18.
//  Copyright © 2018 Wameedh Mohammed Ali. All rights reserved.
//

//  This is the model class that represents the blueprint for a player

struct Player {
    
//The status of the player is true if the player is alive which is the defulte value, and it is false if the player is dead
    var name: String = ""
    var uid: String = ""
    var status = true
    var role: String = ""
    var group: Int = 0
    
    
    func printInfo() {
        print("Player Name: \(self.name)")
        print("ID: \(self.uid)")
        print("Role: \(self.role)")
        print("Status: \(self.status)")
    }
}




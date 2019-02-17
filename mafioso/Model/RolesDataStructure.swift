//
//  RolesDataStructure.swift
//  mafioso
//
//  Created by Wameedh Mohammed Ali on 1/23/19.
//  Copyright © 2019 Wameedh Mohammed Ali. All rights reserved.
//

import UIKit
import Firebase

class RolesData {
    
    static var roles: [[String]] = [
        //THE INNOCENTS
        ["Innocent",
        "The Detective",
        "The Doctor",
        "The Vigilante",
        "The Magician",
       "The Veteran",
        "Cupid And The Lovers",
        "The Armor"],
        
        // THE MAFIA
       ["Mafia",
       "The Barman",
       "The Bandit",
       "Rambo"],
       
       //OTHERS
      ["The Lycan",
       "The Lawyer",
    "The Peeping-Tom",
    "The Informant",
    "The Bus Driver",
    "The Other (Alien)"]
]
    
    
    static var description: [String: String] = ["Innocent": "Also known as the “townspeople,” these players only know the number of Mafia in the game. There are fewer Innocents than Mafia members.",
    
    "Mafia": "The Mafia determine who will be killed. They also know the identities of their teammates.",
    
    "The Detective": "An Innocent who learns the team of one player every night.",
    
    "The Doctor": "An Innocent may protect a player or himself/herself from death each night.",
    
    "The Barman": "A Mafia member who may cancel the effect of another player’s ability every night.",
    
    "The Vigilante": "An Innocent who may kill a player every night.",
    
    "The Magician": "On the side of the Innocents; can choose to kill one person who they suspect is Mafia each night or can save one person from being lynched by signaling to the Moderator; can do each of things only once.",
    
    "The Lycan": "An Innocent or a Mafioso; appear to be Mafia during the night; this role helps the Mafia; if killed, they are revealed to be a Mafia member.",
    
    "The Peeping-Tom": "Allowed to open their eyes at any moment; knows who is who in the game; very likely to be killed for this knowledge.",
    
    "The Veteran": "An innocent who visits during the night and kills any player they wish; if investigated by the Detective, they die, but if the Mafia attempts to kill her/him, a random Mafia is killed; cannot be killed by the Mafia; no one knows if deaths are caused by her or another player.",
    
    "Cupid and the Lovers": "Cupid is on the innocent team and picks two people to be the Lovers the first night, one of whom dies immediately; the other dies of a broken heart. Alternatively, the Lovers can be awakened by the Moderator during the first night and told of their roles. If one is a victim, the other dies also.",
    
    "The Informant": "Gets to know who the Mafia is but their identity remains unknown. During the first night cycle, the Moderator lets the Informant see who the Mafia members. The Mafia members keep their eyes closed and raise their hands. The Informant helps the Innocents, but need to do so secretively or is likely to be killed.",
    
    "The Armor": "This player cannot be killed by Mafia and only be voted off.",
    
    "The Bandit": "Has not voting power; knows who the Mafia is; works to aid the Mafia.",
    
    "The Lawyer": "Chooses someone to defend; that person cannot be voted out the following morning.",
    
    "Rambo": "Able to throw a “grenade” at someone and kill that person and the two people sitting on either side.",
    
    "The Bus Driver": "Can blindly change two player’s roles.",
    
    "The Other (Alien)": "Looks like an innocent. Awakens after the Doctor and Mafia have finished their parts. If the Alien is picked for killing, the Moderator advises the Other secretly. At this point, the Other attempts to be hung. If successful, the Other stays in the game (or wins). If hung before activation, the other is out of the game."
    ]
    
class func observer() {
    Database.database().reference().child("RoleData12051989786").observe(.value) { (snapshot) in
        
        
        if let value = snapshot.value as? [String: AnyObject], let roles = value["Roles"] as? [[String]],             let description = value["description"] as? [String: String] {
         
            self.roles = roles
            self.description = description
            
        } else {
            print("Roles data has not been modeled!")
        }
       
        }
    }
}

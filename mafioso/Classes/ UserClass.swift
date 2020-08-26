//
//  UserClass.swift
//  mafioso
//
//  Created by Wameedh Mohammed Ali on 1/2/19.
//  Copyright © 2019 Wameedh Mohammed Ali. All rights reserved.
//

import Foundation


class User {
    
    let name: String
    let email: String
    let gameCode: String
    
    let arrayOfUserAttributes = ["Name", "Email"]
    
    init(name: String, email: String, gameCode: String) {
        self.name = name
        self.email = email
        self.gameCode = gameCode
    }
    
    func UserInfoArray() -> [String] {
        return [name, email, gameCode]
    }
    
}

//
//  errorsEnum.swift
//  mafioso
//
//  Created by Wameedh Mohammed Ali on 1/1/19.
//  Copyright © 2019 Wameedh Mohammed Ali. All rights reserved.
//

import Foundation

enum appErrors: Error {
    case invalidEmail
    case invalidInput
    case unableToSiginOut
    
    case SmothingWentWrong(reason: String)
    
}

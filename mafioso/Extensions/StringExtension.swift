//
//  StringExtension.swift
//  mafioso
//
//  Created by Wameedh Mohammed Ali on 2/10/19.
//  Copyright © 2019 Wameedh Mohammed Ali. All rights reserved.
//

import Foundation
extension String {
    func boolValueFromString() -> Bool {
        return NSString(string: self).boolValue
    }
}

//
//  UIStoryboardSegueWithCompletion.swift
//  mafioso
//
//  Created by Wameedh Mohammed Ali on 2/7/19.
//  Copyright © 2019 Wameedh Mohammed Ali. All rights reserved.
//

import UIKit

class UIStoryboardSegueWithCompletion: UIStoryboardSegue {
    var completion: (() -> Void)?
    
    
    override func perform() {
        super.perform()
        if let completion = completion {
            completion()
        }
    }
}

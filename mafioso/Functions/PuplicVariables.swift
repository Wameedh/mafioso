//
//  PuplicVariables.swift
//  mafioso
//
//  Created by Wameedh Mohammed Ali on 2/15/19.
//  Copyright © 2019 Wameedh Mohammed Ali. All rights reserved.
//

import UIKit

let primeryColor = #colorLiteral(red: 0.2381011844, green: 0.6540691257, blue: 0.4755768776, alpha: 1)

var randomColor: UIColor {
    let hue : CGFloat = CGFloat(arc4random() % 256) / 256 // use 256 to get full range from 0.0 to 1.0
    let saturation : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from white
    let brightness : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from black
    return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
}



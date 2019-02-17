//
//  Functions.swift
//  mafioso
//
//  Created by Wameedh Mohammed Ali on 2/10/19.
//  Copyright © 2019 Wameedh Mohammed Ali. All rights reserved.
//


import UIKit
import Firebase
import SVProgressHUD

func presentAlert(title: String?, message: String?, vc: UIViewController, action: UIAlertAction, cancelAction: UIAlertAction?){
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    alert.addAction(action)
    
    alert.addAction(cancelAction ?? UIAlertAction(title: "No", style: .cancel, handler: nil))
    
    
    vc.present(alert, animated: true)
}


func playerForCell(sectionIndex: Int, rowIndex: Int, game: Game) -> Player {
    
    switch (sectionIndex) {
    case 0:
        return game.innocentsGroup[rowIndex]
        
    case 1:
        return game.mafiaGroup[rowIndex]
        
    default:
        return game.othersGroup[rowIndex]
    }
}


func ShowCustomSVProgressHUD() {
    SVProgressHUD.setDefaultMaskType(.black)
    SVProgressHUD.setForegroundColor(primeryColor)
    SVProgressHUD.show()
}


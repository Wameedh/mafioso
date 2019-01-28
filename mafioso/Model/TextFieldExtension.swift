////
////  UIDevice.swift
////  mafioso
////
////  Created by Wameedh Mohammed Ali on 12/30/18.
////  Copyright © 2018 Wameedh Mohammed Ali. All rights reserved.
////
//
import UIKit

extension UITextField {
    func setBottomBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.5)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}


extension String {
    func boolValueFromString() -> Bool {
        return NSString(string: self).boolValue
    }
}

func presentAlert(title: String, message: String, vc: UIViewController){
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (_) in
        vc.performSegue(withIdentifier: "unwindToNewJoinGame", sender: vc)
    }))
    
    alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
    
    vc.present(alert, animated: true)
}



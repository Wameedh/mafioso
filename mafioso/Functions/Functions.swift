//
//  Functions.swift
//  mafioso
//
//  Created by Wameedh Mohammed Ali on 2/10/19.
//  Copyright © 2019 Wameedh Mohammed Ali. All rights reserved.
//


import UIKit

func presentAlert(title: String, message: String, vc: UIViewController, action: UIAlertAction){
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    alert.addAction(action)
    
    alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
    
    vc.present(alert, animated: true)
}

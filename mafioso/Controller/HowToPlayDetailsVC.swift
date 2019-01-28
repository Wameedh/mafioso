//
//  HowToPlayDetailsVC.swift
//  mafioso
//
//  Created by Wameedh Mohammed Ali on 11/3/18.
//  Copyright © 2018 Wameedh Mohammed Ali. All rights reserved.
//

import UIKit

class HowToPlayDetailsVC: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var howToPlayDetailsLable: UILabel!
    
    
    var content: String = ""
    
    
    
    override func viewDidLoad() {
        howToPlayDetailsLable.widthAnchor.constraint(equalToConstant: self.view.frame.width - 40).isActive = true
        howToPlayDetailsLable.text = content
    }
    
    
    
}

//
//  NumberOfPlayersVC.swift
//  mafioso
//
//  Created by Wameedh Mohammed Ali on 10/28/18.
//  Copyright © 2018 Wameedh Mohammed Ali. All rights reserved.
//

import UIKit

class NumberOfPlayersVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var randomColor: UIColor {
        let hue : CGFloat = CGFloat(arc4random() % 256) / 256 // use 256 to get full range from 0.0 to 1.0
        let saturation : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from white
        let brightness : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from black
        
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
    }
    
    
    let numberOfPlayersArray = ["5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24"]
    
    var colorArray = [UIColor]()
    
    @IBOutlet weak var numberOfPlayersPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        numberOfPlayersPicker.delegate = self
        numberOfPlayersPicker.dataSource = self
        
        //Generating an array of random colors that is used for piker view title's color and the for each playes background color!
        for _ in 1...numberOfPlayersArray.count {
            colorArray.append(randomColor)
        }
    }
    
    
    // 3 UIPickerView delegate methods here
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numberOfPlayersArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return numberOfPlayersArray[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        print(row + 5)
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        let titleData = numberOfPlayersArray[row]
        
        return NSAttributedString(string: titleData, attributes: [NSAttributedString.Key.foregroundColor: colorArray[row]])
    }
    
    
    
    
}

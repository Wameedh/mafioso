//
//  NumberOfPlayersVC.swift
//  mafioso
//
//  Created by Wameedh Mohammed Ali on 10/28/18.
//  Copyright © 2018 Wameedh Mohammed Ali. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class NumberOfPlayersVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    lazy var functions = Functions.functions()
    var ref = Database.database().reference()
    
    let numberOfPlayersArray = ["5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24"]
    
    var numberOfPlayers = 5
    var colorArray = [UIColor]()
    var gameCode = ""
    
    @IBOutlet weak var numberOfPlayersPicker: UIPickerView!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberOfPlayersPicker.delegate = self
        numberOfPlayersPicker.dataSource = self
        //Generating an array of random colors that is used for piker view title's color and the for each playes background color!
        for _ in 1...numberOfPlayersArray.count {
            colorArray.append(randomColor)
        }
    }
    
    
    // UIPickerView delegate methods here
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
        numberOfPlayers = row + 5
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        let titleData = numberOfPlayersArray[row]
        
        return NSAttributedString(string: titleData, attributes: [NSAttributedString.Key.foregroundColor: colorArray[row]])
    }
    
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        ShowCustomSVProgressHUD()
        nextButton.isEnabled = false
        let data = ["numberOfPlayers": numberOfPlayers] as [String : Any]
        //handle error
        functions.httpsCallable("addGame").call(data) { (result, error) in
            if let error = error as NSError? {
                if error.domain == FunctionsErrorDomain {
                    let errorCode = FunctionsErrorCode(rawValue: error.code)
                    let message = error.localizedDescription
                    let details = error.userInfo[FunctionsErrorDetailsKey]
                    print("\(String(describing: errorCode)) + \(message) + \(String(describing: details))")
                    self.nextButton.isEnabled = true
                    SVProgressHUD.dismiss()
                }
            } else if let code = (result?.data as? [String: Any])?["gameCode"] as? String {
                self.gameCode = code
                
                if let uid = Auth.auth().currentUser?.uid  {
                    self.ref.child("Users").child(uid).setValue(["moderator": code])
                           }
                
                self.performSegue(withIdentifier: "playVC", sender: self)
                
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "playVC"{
           nextButton.isEnabled = true
            let destinationVC = segue.destination as? PlayVC
                destinationVC?.gameCode = gameCode
                destinationVC?.numberOfPlayers = numberOfPlayers
            
        }
    }
    
}

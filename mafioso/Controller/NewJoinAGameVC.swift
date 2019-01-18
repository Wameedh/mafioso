//
//  ViewController.swift
//  mafioso
//
//  Created by Wameedh Mohammed Ali on 9/27/18.
//  Copyright © 2018 Wameedh Mohammed Ali. All rights reserved.
//

import UIKit

class NewJoinAGameVC: UIViewController {

//    lazy var functions = Functions.functions()
//
//    func randomString(length: Int) -> String {
//        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
//        return String((0...length-1).map{ _ in letters.randomElement()! }).uppercased()
//    }
//
//
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       //print(UIDevice.current.ipAddress())
}
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "numberofPlayerVC"{
//            let destinationVC = segue.destination as? NumberOfPlayersVC
//           destinationVC?.randomString = randomString(length: 5)
//
//        }
//    }
    
    
    @IBAction func newGamePressed(_ sender: Any) {
        performSegue(withIdentifier: "numberofPlayerVC", sender: self)
    }
    

}


//
//  SginUpVC.swift
//  mafioso
//
//  Created by Wameedh Mohammed Ali on 1/1/19.
//  Copyright © 2019 Wameedh Mohammed Ali. All rights reserved.
//

import UIKit
import SVProgressHUD
import FirebaseAuth

class SginUpVC: UIViewController {
    
    
    //Pre-linked IBOutlets
    @IBOutlet var nameTextfield: UITextField!
    
    @IBOutlet var emailTextfield: UITextField!
    
    @IBOutlet var passwordTextfield: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextfield.setBottomBorder()
        emailTextfield.setBottomBorder()
        passwordTextfield.setBottomBorder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
}

    @IBAction func sginUpPressed(_ sender: AnyObject) {
        
        SVProgressHUD.show()
        
        //Set up a new user on Firebase database
        
    if let email = emailTextfield.text , let password = passwordTextfield.text, let name = nameTextfield.text {
            
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in

            if error != nil {
                print(error!)
            } else {
                print("Registration Successful!")
               //update the profile by adding the user name
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = name
                changeRequest?.commitChanges(completion: { (error) in
                    if let error = error {
                        print(error.localizedDescription)
                    }
                })
                
                print("Registration Successful!")
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: "newJoinAGameVC", sender: self)
            }
        }
    } else {
        //handle the error of email or password text feilds are empty
        }
    }


}

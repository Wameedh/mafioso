//
//  SginUpVC.swift
//  mafioso
//
//  Created by Wameedh Mohammed Ali on 1/1/19.
//  Copyright © 2019 Wameedh Mohammed Ali. All rights reserved.
//

import UIKit
import SVProgressHUD
import Firebase

class SginUpVC: UIViewController, UITextFieldDelegate {
    
    
    //Pre-linked IBOutlets
    @IBOutlet var nameTextfield: UITextField!
    
    @IBOutlet var emailTextfield: UITextField!
    
    @IBOutlet var passwordTextfield: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Sgin Up"
        nameTextfield.setBottomBorder()
        emailTextfield.setBottomBorder()
        passwordTextfield.setBottomBorder()
        self.passwordTextfield.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //textField code
        
        textField.resignFirstResponder()  //if desired
        signUp()
        return true
    }
    
    
    
    func signUp() {
        ShowCustomSVProgressHUD()
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
                    guard let uid = Auth.auth().currentUser?.uid else {
                        return
                    }
                    Database.database().reference().child("Users").child(uid).setValue(["gameCode": nil])
                    changeRequest?.commitChanges(completion: { (error) in
                        if let error = error {
                            print(error.localizedDescription)
                        }
                    })
                    
                    print("Registration Successful!")
                    self.performSegue(withIdentifier: "newJoinAGameVC", sender: self)
                }
            }
        } else {
            //handle the error of email or password text feilds are empty
        }
    }
    
    
    @IBAction func sginUpPressed(_ sender: AnyObject) {
        signUp()
        
    }
    
    
}

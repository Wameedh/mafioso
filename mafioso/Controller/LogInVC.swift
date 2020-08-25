//
//  LoginVC.swift
//  mafioso
//
//  Created by Wameedh Mohammed Ali on 1/1/19.
//  Copyright © 2019 Wameedh Mohammed Ali. All rights reserved.
//

import UIKit
import FirebaseAuth
import SVProgressHUD

class LogInVC: UIViewController, UITextFieldDelegate {
    
    //Textfields pre-linked with IBOutlets
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Login"
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
       logIn()
        return true
    }
    
    
    func logIn() {
        ShowCustomSVProgressHUD()
        
        if let email = emailTextfield.text , let password = passwordTextfield.text {
            
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in if error != nil {
                print(error!)
                SVProgressHUD.dismiss()
                
                self.errorLabel.text = error?.localizedDescription
            } else {
                print("Log in successful!")
                self.performSegue(withIdentifier: "newJoinAGameVC", sender: self)
                
                }
                
            }
            
        }
    }
    
    //Log in an existing user
    
    @IBAction func logInPressed(_ sender: AnyObject) {
        logIn()
 }
    
    
    
}

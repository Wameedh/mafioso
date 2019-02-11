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

class LogInVC: UIViewController {
    
    //Textfields pre-linked with IBOutlets
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Login"
        emailTextfield.setBottomBorder()
        passwordTextfield.setBottomBorder()
   
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //Log in an existing user
    
    @IBAction func logInPressed(_ sender: AnyObject) {
        
        SVProgressHUD.show()
        
        
        if let email = emailTextfield.text , let password = passwordTextfield.text {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in if error != nil {
                print(error!)
            } else {
                print("Log in successful!")
                
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: "newJoinAGameVC", sender: self)
                
            }
            
        }
        
     }
 }
    
    
    
}

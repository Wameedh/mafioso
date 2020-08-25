//
//  ViewController.swift
//  mafioso
//
//  Created by Wameedh Mohammed Ali on 9/27/18.
//  Copyright © 2018 Wameedh Mohammed Ali. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class NewJoinAGameVC: UIViewController {
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        SVProgressHUD.dismiss()
        VCSwitcher.checkIfUserIsPartOfAGame(rootViewController: self)
        RolesData.observer()
    }
    
    
    
    @IBAction func unwindToNewJoinGameView(segue: UIStoryboardSegue) {}

    
    
    
    @IBAction func newGamePressed(_ sender: Any) {
        performSegue(withIdentifier: "numberofPlayerVC", sender: self)
    }
    
    
 // MARK: - Navigation
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if identifier == "toProfileVC" {
            if let currentUser = Auth.auth().currentUser {
                if let name = currentUser.displayName, let email = currentUser.email {
                    user = User(name: name, email: email, gameCode: "")
                    return true
                } else {
                    
                    
                    presentAlert(title: "Error!", message: "Something went wrong when getting user info, do you want to sign out?",vc: self, action:
                     UIAlertAction(title: "Yes", style: .destructive, handler: { (_) in
                        
                        do {
                            try signOutAndPresentWelcomeVC(viewController: self)
                        }
                        catch {
                            print("error: there was a problem logging out")
                        }
                         
                         }), cancelAction: nil)
                    
                    return false
                   
                }
            }
            
        }
        
        return true
        
    }
    
   
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           
           if segue.identifier == "toProfileVC" {
               let destinationVC = segue.destination as? ProfileTableVC
               
            destinationVC?.user = user
            destinationVC?.UserInfoArray = user.UserInfoArray()
           }
       }
    
    
} // End of NewJoinAGameVC class


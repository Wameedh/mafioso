//
//  ProfileTableVC.swift
//  mafioso
//
//  Created by Wameedh Mohammed Ali on 1/2/19.
//  Copyright © 2019 Wameedh Mohammed Ali. All rights reserved.
//

import UIKit
import FirebaseAuth


class ProfileTableVC: UITableViewController {
    
    var user: User!
    var UserInfoArray: [String] = []
    
    @IBOutlet weak var signOutButton: UIButton!
    
    
    override func viewDidLoad() {
    
        retrieveUserInfo()
        setPositionSginOutButton()
        
    }
    
    
    private func setPositionSginOutButton() {
        // set position
        signOutButton.translatesAutoresizingMaskIntoConstraints = false
        signOutButton.leftAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.leftAnchor).isActive = true
        signOutButton.rightAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.rightAnchor).isActive = true
        signOutButton.bottomAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.bottomAnchor).isActive = true
        signOutButton.widthAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.widthAnchor).isActive = true
        signOutButton.heightAnchor.constraint(equalToConstant: 50).isActive = true // specify the height of the view
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserInfoArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath)
        
        cell.textLabel?.text = user.arrayOfUserAttributes[indexPath.row]
        cell.detailTextLabel?.text = UserInfoArray[indexPath.row]
        
        return cell
        
    
    }
    
    func retrieveUserInfo() {
        
        let currentUser = Auth.auth().currentUser!
       
        if let name = currentUser.displayName, let email = currentUser.email {
            user = User(name: name, email: email)
            UserInfoArray = user.UserInfoArray()
        } else {
            print("No User info!!")
        }
    }
    
    
    @IBAction func signOutPressed(resultButton sender: Any) {
        
        do {
           try signOutAndPresentWelcomeVC()
        }
        catch {
            print("error: there was a problem logging out")
        }
     }
    
    
    func signOutAndPresentWelcomeVC() throws {
       
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "welcomeVC"){
            self.present(vc, animated:true, completion: nil)
            try Auth.auth().signOut()
            
        }else{
            throw appErrors.unableToSiginOut
        }
    }
    
    }
    
    



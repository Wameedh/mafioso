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
         super.viewDidLoad()
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
        return user.arrayOfUserAttributes.count
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
    
    
    @IBAction func signOutPressed(resultButton sender: Any) {
        
        do {
           try signOutAndPresentWelcomeVC(viewController: self)
        }
        catch {
            print("error: there was a problem logging out")
        }
     }
    
}
    
    



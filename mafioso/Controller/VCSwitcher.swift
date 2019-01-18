////
////  VCSwitcher.swift
////  mafioso
////
////  Created by Wameedh Mohammed Ali on 1/3/19.
////  Copyright © 2019 Wameedh Mohammed Ali. All rights reserved.
////
//
//import UIKit
//import FirebaseAuth
//
//class VCSwitcher {
//    
//    static func updateRootVC(){
//        
//        let status = Auth.auth().currentUser
//        var rootVC : UIViewController
//        
//        print(status)
//        
//        
//        if(status != nil){
//            rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "newJoinAGameVC") as! NewJoinAGameVC
//        }else{
//            rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "welcomeVC") as! WelcomeVC
//        }
//        
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.window?.rootViewController = rootVC
//        
//    }
//    
//}

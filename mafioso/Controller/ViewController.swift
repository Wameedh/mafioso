//
//  ViewController.swift
//  mafioso
//
//  Created by Wameedh Mohammed Ali on 9/27/18.
//  Copyright © 2018 Wameedh Mohammed Ali. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    
    lazy var functions = Functions.functions()
    
    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0...length-1).map{ _ in letters.randomElement()! }).uppercased()
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("IP")
       print(UIDevice.current.ipAddress())
        
        if let addr = getWiFiAddress() {
            print(addr)
        } else {
            print("No WiFi address")
        }
}
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "numberofPlayerVC"{
            let destinationVC = segue.destination as? NumberOfPlayersVC
            destinationVC?.randomString = randomString(length: 5)
            
        }
    }
    
    
    @IBAction func newGamePressed(_ sender: Any) {
        performSegue(withIdentifier: "numberofPlayerVC", sender: self)
    }
    
    
    
    
    
    func getWiFiAddress() -> String? {
        var address : String?
        
        // Get list of all interfaces on the local machine:
        var ifaddr : UnsafeMutablePointer<ifaddrs>?
        guard getifaddrs(&ifaddr) == 0 else { return nil }
        guard let firstAddr = ifaddr else { return nil }
        
        // For each interface ...
        for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let interface = ifptr.pointee
            
            // Check for IPv4 or IPv6 interface:
            let addrFamily = interface.ifa_addr.pointee.sa_family
            //if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {  // **ipv6 committed
            if addrFamily == UInt8(AF_INET){
                
                // Check interface name:
                let name = String(cString: interface.ifa_name)
                if  name == "en0" {
                    
                    // Convert interface address to a human readable string:
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    getnameinfo(interface.ifa_addr, socklen_t(interface.ifa_addr.pointee.sa_len),
                                &hostname, socklen_t(hostname.count),
                                nil, socklen_t(0), NI_NUMERICHOST)
                    address = String(cString: hostname)
                }
            }
        }
        freeifaddrs(ifaddr)
        
        return address
    }
    
    
    
    

}


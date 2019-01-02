//
//  PlayerClass.swift
//  mafioso
//
//  Created by Wameedh Mohammed Ali on 10/31/18.
//  Copyright © 2018 Wameedh Mohammed Ali. All rights reserved.
//

//  This is the model class that represents the blueprint for a player

class Player {
    
    var name: String
    var role: String
    //The status of the player is true if the player is alive which is the defulte value, and it is false if the player is dead
    var status: Bool
    
    init(playerName: String, title: String, status: Bool){
        self.name = playerName
        self.role = title
        self.status = status
    }
}




//class func getIPAddress() -> String? {
//    var address: String?
//    var ifaddr: UnsafeMutablePointer<ifaddrs>? = nil
//    if getifaddrs(&ifaddr) == 0 {
//        var ptr = ifaddr
//        while ptr != nil {
//            defer { ptr = ptr?.pointee.ifa_next }
//            
//            let interface = ptr?.pointee
//            let addrFamily = interface?.ifa_addr.pointee.sa_family
//            if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
//                
//                if let name: String = String(cString: (interface?.ifa_name)!), name == "en0" {
//                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
//                    getnameinfo(interface?.ifa_addr, socklen_t((interface?.ifa_addr.pointee.sa_len)!), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST)
//                    address = String(cString: hostname)
//                }
//            }
//        }
//        freeifaddrs(ifaddr)
//    }
//    return address
//}


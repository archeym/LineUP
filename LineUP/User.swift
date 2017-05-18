//
//  User.swift
//  LineUP
//
//  Created by ardMac on 17/05/2017.
//  Copyright © 2017 ArchieApps. All rights reserved.
//

import Foundation

class User{
    var name : String = ""
    var email : String = ""
    var annualLeaves : Int = 0
    var department : String = ""
    var position : String = ""
    var supervisor : String = ""
    var phoneNumber : String = ""
    var address : String = ""
    
    
    init (dict : [String: Any]) {
        name = dict["name"] as? String ?? "Mahmoud"
        email = dict["email"] as? String ?? ""
        annualLeaves = dict["leaves_no"] as! Int
        department = dict["department"] as? String ?? ""
        position = dict["position"] as? String ?? ""
        supervisor = dict["supervisor"] as? String ?? ""
        phoneNumber = dict["phoneNumber"] as? String ?? ""
        address = dict["dict"] as? String ?? ""
    }
}

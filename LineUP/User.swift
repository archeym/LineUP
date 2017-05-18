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
    var maternityLeave : Int = 0
    var paternityLeave : Int = 0
    var emergencyLeave : Int = 0
    var studyLeave : Int = 0
    
    init (dict : [String: Any]) {
        name = dict["name"] as? String ?? "Mahmoud"
        email = dict["email"] as? String ?? ""
        annualLeaves = dict["leaves_no"] as! Int
        department = dict["department"] as? String ?? ""
        position = dict["position"] as? String ?? ""
        supervisor = dict["supervisor"] as? String ?? ""
        phoneNumber = dict["phoneNumber"] as? String ?? ""
        address = dict["dict"] as? String ?? ""
//        maternityLeave = dict[""] as! Int
//        paternityLeave = dict[""] as! Int
//        emergencyLeave = dict[""] as! Int
//        studyLeave = dict[""] as! Int
    }
}
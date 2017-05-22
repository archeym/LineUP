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
    var department : String = ""
    var position : String = ""
    //var supervisor : String = ""
    var phoneNumber : String = ""
    var address : String = ""
    
    var annualLeaves : Int = 0
    var sickLeaves : Int = 0
    var maternityLeave : Int = 0
    var nonPaid : Int = 0
    var emergencyLeave : Int = 0
    var studyLeave : Int = 0
    
    var profilePhoto : String = ""
    
    init (dict : [String: Any] ) {//, dictB: [String: Any]
        name = dict["name"] as? String ?? ""
        email = dict["email"] as? String ?? ""
        department = dict["department"] as? String ?? ""
        position = dict["position"] as? String ?? ""
        //supervisor = dictB["manager_name"] as? String ?? ""
        phoneNumber = dict["phone_no"] as? String ?? ""
        address = dict["address"] as? String ?? ""
        
        annualLeaves = dict["leaves_no"] as? Int ?? 0
        sickLeaves = dict["sick"] as? Int ?? 0
        maternityLeave = dict["maternity"] as? Int ?? 0
        nonPaid = dict["non_paid"] as? Int ?? 0
        emergencyLeave = dict["emergency"] as? Int ?? 0
        studyLeave = dict["study"] as? Int ?? 0
        //profilePhoto = dict["avatar"] as? String ?? ""
    }
}

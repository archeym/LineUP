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
    

    var profilePhoto : String = ""
    
    init (dict : [String: Any] ) {//, dictB: [String: Any]
        name = dict["name"] as? String ?? ""
        email = dict["email"] as? String ?? ""
        department = dict["department"] as? String ?? ""
        position = dict["position"] as? String ?? ""
        //supervisor = dictB["manager_name"] as? String ?? ""
        phoneNumber = dict["phone_no"] as? String ?? ""
        address = dict["address"] as? String ?? ""
        
        profilePhoto = ""
        if let avatar = dict["avatar"] as? [String:Any] {
            profilePhoto = avatar["url"] as? String ?? ""
        }
    }
    
    
}


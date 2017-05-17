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
    
    init (dict : [String: Any]) {
        name = dict["name"] as? String ?? "Mahmoud"
    }
}

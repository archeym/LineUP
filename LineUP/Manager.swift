//
//  Manager.swift
//  LineUP
//
//  Created by Arkadijs Makarenko on 22/05/2017.
//  Copyright © 2017 ArchieApps. All rights reserved.
//

import Foundation

class Manager{
    var supervisor : String = ""
    
    init (dictB : [String: Any] ) {
        supervisor = dictB["name"] as? String ?? "Khang Hui"
    }
}

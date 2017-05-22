//
//  Leave.swift
//  LineUP
//
//  Created by ardMac on 20/05/2017.
//  Copyright © 2017 ArchieApps. All rights reserved.
//

import Foundation

class Leave{
    var leaveType : String = ""
    var startDate : String = ""
    var endDate : String = ""
    var totalDays : Int = 0
    var status : String = ""
    var leaveId : Int = 0
    
    init (dict : [String: Any]) {
        leaveType = dict["leave_type"] as? String ?? ""
        startDate = dict["start_date"] as? String ?? ""
        endDate = dict["end_date"] as? String ?? ""
        totalDays = dict["total_days"] as? Int ?? 0
        status = dict["status"] as? String ?? ""
        leaveId = dict["id"] as? Int ?? 0
    }
}

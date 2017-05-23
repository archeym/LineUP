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
    
    var annualLeaves : Int = 0
    var sickLeaves : Int = 0
    var maternityLeave : Int = 0
    var nonPaid : Int = 0
    var emergencyLeave : Int = 0
    var studyLeave : Int = 0
    
    
    init (dict : [String: Any]) {
        leaveType = dict["leave_type"] as? String ?? ""
        startDate = dict["start_date"] as? String ?? ""
        endDate = dict["end_date"] as? String ?? ""
        totalDays = dict["total_days"] as? Int ?? 0
        status = dict["status"] as? String ?? ""
        leaveId = dict["id"] as? Int ?? 0
    }
    
    init (leaveDict : [String : Any]) {
        annualLeaves = leaveDict["annual"] as? Int ?? 0
        sickLeaves = leaveDict["sick"] as? Int ?? 0
        maternityLeave = leaveDict["maternity"] as? Int ?? 0
        nonPaid = leaveDict["non_paid"] as? Int ?? 0
        emergencyLeave = leaveDict["emergency"] as? Int ?? 0
        studyLeave = leaveDict["study"] as? Int ?? 0
    }
}

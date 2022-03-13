//
//  HistoryTableViewCellViewModel.swift
//  MedTrack
//
//  Created by Sajith Konara on 2022-03-13.
//

import Foundation

class HistoryTableViewCellViewModel{
    
    var record:MedTrackerDTO
    
    init(record:MedTrackerDTO){
        self.record = record
    }
    
    var isMorningMedTaken:Bool{
        record.morningDate != nil
    }
    
    var isEveningMedTaken:Bool{
        record.eveningDate != nil
    }
    
    var isNightMedTaken:Bool{
        record.nightDate != nil
    }
    
    var morningMedTime:String?{
        return record.morningDate != nil ? " \(record.morningDate?.getTimeString() ?? "") " : ""
    }
    
    var eveningMedTime:String?{
        return record.eveningDate != nil ? " \(record.eveningDate?.getTimeString() ?? "") " : ""
    }
    
    var nightMedTime:String?{
        return record.nightDate != nil ? " \(record.nightDate?.getTimeString() ?? "") " : ""
    }
    
    var score:Int{
        record.score
    }
    
    var descriptiveDateString:String{
        record.date.getDescriptiveDateString()
    }
    
    
    
}

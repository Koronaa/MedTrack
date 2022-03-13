//
//  HistoryTableViewCellViewModel.swift
//  MedTrack
//
//  Created by Sajith Konara on 2022-03-13.
//

import Foundation
import RxRelay

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
    
    var score:Int{
        var score = 0
        
        if isMorningMedTaken{
            score += 30
        }
        
        if isEveningMedTaken{
            score += 30
        }
        
        if isNightMedTaken{
            score += 40
        }
        
        return score
    }
    
    var descriptiveDateString:String{
        record.date.getDescriptiveDateString()
    }
    
    
    
}

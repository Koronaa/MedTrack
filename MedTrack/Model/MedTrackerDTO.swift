//
//  MedTrackerDTO.swift
//  MedTrack
//
//  Created by Sajith Konara on 2022-03-13.
//

import Foundation

struct MedTrackerDTO{
    
    var date:Date
    var morningDate:Date?
    var eveningDate:Date?
    var nightDate:Date?
    var score:Int
    
    static func calculateScore(for record:MedTrackerDTO) -> Int{
        var score = 0
        
        if record.morningDate != nil{
            score += 30
        }
        
        if record.eveningDate != nil{
            score += 30
        }
        
        if record.nightDate != nil{
            score += 40
        }
        
        return score
    }
    
}

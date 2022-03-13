//
//  Date+Extensions.swift
//  MedTrack
//
//  Created by Sajith Konara on 2022-03-13.
//

import Foundation

extension Date{
    
    var removeTimeStamp:Date{
        let date = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: self))
        return date!
    }
    
    func getDescriptiveDateString() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM, yyyy"
        return formatter.string(from: self)
    }
    
}

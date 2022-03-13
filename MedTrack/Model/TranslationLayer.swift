//
//  TranslationLayer.swift
//  MedTrack
//
//  Created by Sajith Konara on 2022-03-13.
//

import Foundation

class TranslationLayer{
    
    func convertToMedTrackDTO(records:[MedTracker]) -> [MedTrackerDTO]{
        var dtos:[MedTrackerDTO] = []
        records.forEach { medTracker in
            dtos.append(MedTrackerDTO(date: medTracker.date, morningDate: medTracker.morningDate, eveningDate: medTracker.eveningDate, nightDate: medTracker.nightDate, score: Int(medTracker.score)))
        }
        return dtos
    }
    
}

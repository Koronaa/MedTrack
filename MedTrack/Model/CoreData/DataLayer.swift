//
//  DataLayer.swift
//  MedTrack
//
//  Created by Sajith Konara on 2022-03-13.
//

import Foundation

class DataLayer{
    
    private let mediTrackerDataService:MedTrackerDataService
    private let translationLayer:TranslationLayer
    private let recentDataCount = 10
    
     init(){
         mediTrackerDataService = MedTrackerDataService()
         translationLayer = TranslationLayer()
     }
    
    func getRecordOrCreateNew(for date:Date) -> MedTrackerDTO{
        if let savedRecord = mediTrackerDataService.getRecord(for: date.removeTimeStamp){
            Log("Record found for date: \(date.description)")
            let recordDTO = translationLayer.convertToMedTrackDTO(records: [savedRecord]).first!
            return recordDTO
        }else{
            Log("No Saved record found for date: \(date.description)")
            Log("Creating a new Record with default values")
            return MedTrackerDTO(date: date.removeTimeStamp, morningDate: nil, eveningDate: nil, nightDate: nil, score: 0)
        }
    }
    
    func createOrUpdateRecord(from record:MedTrackerDTO) -> Bool{
        let isUpdated = mediTrackerDataService.updateRecord(for: record.date, updatedRecord: record)
        return isUpdated ? isUpdated : mediTrackerDataService.addRecord(using: record)
    }
    
    func getRecentRecords() -> [MedTrackerDTO]?{
        if let savedRecords = mediTrackerDataService.getAllRecords(){
            let slice =  translationLayer.convertToMedTrackDTO(records: savedRecords).prefix(recentDataCount)
            let records = Array(slice)
            Log("Recent Records: \(records.count) records found")
            return records
        }
        Log("No Records found")
        return nil
    }
    
    func getAllRecords() -> [MedTrackerDTO]?{
        if let savedRecords = mediTrackerDataService.getAllRecords(){
            let convertedRecords =  translationLayer.convertToMedTrackDTO(records: savedRecords)
            Log("Found \(convertedRecords.count) records")
            return convertedRecords
        }
        Log("No Records found")
        return nil
    }

}

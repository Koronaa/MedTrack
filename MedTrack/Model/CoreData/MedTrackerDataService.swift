//
//  MedTrackerDataService.swift
//  MedTrack
//
//  Created by Sajith Konara on 2022-03-13.
//

import Foundation
import CoreData
import UIKit

class MedTrackerDataService{
    
    private var fetchRequest:NSFetchRequest<MedTracker>{
        return NSFetchRequest<MedTracker>(entityName: MedTracker.entityName)
    }
    
    private var context:NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    
    func getAllRecords() -> [MedTracker]?{
        let recordsFetchRequest = fetchRequest
        let sortDescriptors = NSSortDescriptor(key: #keyPath(MedTracker.date), ascending: false)
        recordsFetchRequest.sortDescriptors = [sortDescriptors]
        
        do{
            let records = try context.fetch(recordsFetchRequest)
            return records
        }catch(let e){
            Log(e.localizedDescription)
            return nil
        }
    }
    
    func getRecord(for date:Date) -> MedTracker?{
        let recordFetchRequest = fetchRequest
        recordFetchRequest.predicate = NSPredicate(format: "date == %@", date as CVarArg)
        
        do{
            let record = try context.fetch(recordFetchRequest)
            return record.first
        }catch(let e){
            Log(e.localizedDescription)
            return nil
        }
    }
    
    func addRecord(using medtracker:MedTrackerDTO) -> Bool{
        let newRecord = NSEntityDescription.insertNewObject(forEntityName: MedTracker.entityName, into: context) as! MedTracker
        newRecord.date = medtracker.date.removeTimeStamp
        newRecord.eveningDate = medtracker.eveningDate
        newRecord.morningDate = medtracker.morningDate
        newRecord.nightDate = medtracker.nightDate
        newRecord.score = Int16(medtracker.score)
        
        do{
            try context.save()
            Log("Record added for data: \(medtracker.date.description)")
        }catch(let e){
            Log(e.localizedDescription)
            return false
        }
        
        return true
    }
    
    func updateRecord(for date:Date,updatedRecord:MedTrackerDTO) -> Bool{
        if let task = getRecord(for: date){
            do{
                task.date = updatedRecord.date.removeTimeStamp
                task.score = Int16(updatedRecord.score)
                task.nightDate = updatedRecord.nightDate
                task.morningDate = updatedRecord.morningDate
                task.eveningDate = updatedRecord.eveningDate
                try context.save()
                Log("Record updated for date: \(date.description)")
            }catch(let e){
                Log(e.localizedDescription)
                context.rollback()
                return false
            }
        }else{
            return false
        }
        return true
    }
    
}

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
    
    
    //TODO: add coredata functions here
    
}

//
//  MedTracker+CoreDataClass.swift
//  MedTrack
//
//  Created by Sajith Konara on 2022-03-13.
//

import Foundation
import CoreData

protocol Entitiable{
    static var entityName:String {get}
}

class MedTracker:NSManagedObject,Entitiable{
    
    @NSManaged var date:Date
    @NSManaged var morningDate:Date?
    @NSManaged var eveningDate:Date?
    @NSManaged var nightDate:Date?
    @NSManaged var score:Int
    
    static var entityName: String { return "MedTracker" }
    
}

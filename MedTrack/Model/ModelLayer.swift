//
//  ModelLayer.swift
//  MedTrack
//
//  Created by Sajith Konara on 2022-03-13.
//

import Foundation
import RxSwift

class ModelLayer{
    
    private let dateLayer:DataLayer
    
    init(){
        dateLayer = DataLayer()
    }
    
    func getRecordOrCreateNew(for date:Date) -> Observable<MedTrackerDTO>{
        Observable<MedTrackerDTO>.create { observer in
            observer.onNext(self.dateLayer.getRecordOrCreateNew(for: date))
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    func createOrUpdateRecord(from record:MedTrackerDTO) -> Observable<Bool>{
        Observable<Bool>.create { observer in
            observer.onNext(self.dateLayer.createOrUpdateRecord(from: record))
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    func getRecentRecords() -> Observable<[MedTrackerDTO]?>{
        Observable<[MedTrackerDTO]?>.create { observer in
            observer.onNext(self.dateLayer.getRecentRecords())
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    func getAllRecords() -> Observable<[MedTrackerDTO]?>{
        Observable<[MedTrackerDTO]?>.create { observer in
            observer.onNext(self.dateLayer.getAllRecords())
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
}


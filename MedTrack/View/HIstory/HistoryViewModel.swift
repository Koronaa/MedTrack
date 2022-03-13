//
//  HistoryViewModel.swift
//  MedTrack
//
//  Created by Sajith Konara on 2022-03-13.
//

import Foundation
import RxSwift
import RxRelay

class HistoryViewModel{
    
    var records:BehaviorRelay<[MedTrackerDTO]?> = BehaviorRelay<[MedTrackerDTO]?>(value: nil)
    var error:BehaviorRelay<UserMessage?> = BehaviorRelay<UserMessage?>(value:nil)
    private let modelLayer = ModelLayer()
    private let bag = DisposeBag()
    
    func getAllRecords(){
        modelLayer.getAllRecords().subscribe(onNext: { [weak self] retrievedRecords in
            if let savedRecords = retrievedRecords{
                self?.records.accept(savedRecords)
            }else{
                let message = UserMessage(title: "No Records Found", message: "Looks like you haven't add any records")
                self?.error.accept(message)
                self?.records.accept([])
            }
        }).disposed(by: bag)
        
    }
}

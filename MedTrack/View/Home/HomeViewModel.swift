//
//  HomeViewModel.swift
//  MedTrack
//
//  Created by Sajith Konara on 2022-03-13.
//

import Foundation
import RxSwift

enum TimePeriod:String,CaseIterable{
    case Morning = "Morning"
    case Afternoon = "Afternoon"
    case Night = "Evening"
    
    
}

class HomeViewModel{
    
    private var currentRecord:MedTrackerDTO?
    var recentRecords:[MedTrackerDTO] = []
    private let modelLayer = ModelLayer()
    private let bag = DisposeBag()
    private let notificationManager = LocalNotificationManager.shared
    
    var score:PublishSubject<Int> = PublishSubject<Int>()
    var errorMessage:PublishSubject<UserMessage> = PublishSubject<UserMessage>()
    var successMessage:PublishSubject<UserMessage> = PublishSubject<UserMessage>()
    var dataUpdated:PublishSubject<Bool> = PublishSubject<Bool>()
    
    init(){
        setupNotifications()
    }
    
    
    var hasTakenNightMed:Bool?{
        currentRecord?.nightDate != nil
    }
    
    var totalRecordsCount:Int{
        recentRecords.count
    }
    
    func getCurrentRecord(){
        modelLayer.getRecordOrCreateNew(for: Date()).subscribe (onNext: { [weak self] dto in
            self?.currentRecord = dto
            self?.score.onNext(dto.score)
        }).disposed(by: bag)
    }
    
    func getGreetingText() -> String{
        let timeOFDay:String = getTimePeriod(for: Date()).rawValue
        return "Hey, Good \(timeOFDay)! 👋🏻"
    }
    
    
    func addRecord(for date:Date,withSilentMode isEnabled:Bool = false){
        
        if !isEnabled{
            let timePedriod = getTimePeriod(for: date)
            switch timePedriod {
            case .Morning:
                currentRecord?.morningDate = date
            case .Afternoon:
                currentRecord?.eveningDate = date
            case .Night:
                currentRecord?.nightDate = date
            }
        }
        
        
        
        let tempRecord = currentRecord!
        currentRecord!.score = MedTrackerDTO.calculateScore(for: tempRecord)
        score.onNext(currentRecord!.score)
        
        
        modelLayer.createOrUpdateRecord(from: currentRecord!).subscribe(onNext: {[weak self] isSuccess in
            if isSuccess{
                let message = UserMessage(title: "Record Added", message: "Record added successfully!")
                self?.dataUpdated.onNext(true)
                if !isEnabled{
                    self?.successMessage.onNext(message)
                }
            }else{
                let message = UserMessage(title: "Record Failed", message: "Something went wrong while saving the record")
                if !isEnabled{
                    self?.errorMessage.onNext(message)
                }
            }
        }).disposed(by: bag)
    }
    
    func getRecentRecords(onComplete:@escaping()->()){
        modelLayer.getRecentRecords().subscribe(onNext: { [weak self] records in
            if let recentRecords = records{
                self?.recentRecords = recentRecords
            }
            onComplete()
        }).disposed(by: bag)
    }
    
    func getDataAvailability(for date:Date) -> Bool{
        let period = getTimePeriod(for: date)
        switch period {
        case .Morning:
            return currentRecord?.morningDate != nil
        case .Afternoon:
            return currentRecord?.eveningDate != nil
        case .Night:
            return currentRecord?.nightDate != nil
        }
    }
    
    private func getTimePeriod(for date:Date) -> TimePeriod{
        let hour = Calendar.current.component(.hour, from: date)
        switch hour{
        case 5..<12:
            return .Morning
        case 12..<18:
            return .Afternoon
        default:
            return .Night
        }
    }
    
    
    
    deinit{
        score.onCompleted()
        errorMessage.onCompleted()
        successMessage.onCompleted()
        dataUpdated.onCompleted()
    }
    
    
}

//MARK: Notifications
extension HomeViewModel{
    
    func setupNotifications(){
        notificationManager.requestAuthorization { [weak self] isAuthorized in
            if isAuthorized && !(self?.hasSetNofifications ?? true){
                self?.scheduleNotification(for: .Morning)
                self?.scheduleNotification(for: .Afternoon)
                self?.scheduleNotification(for: .Night)
            }
        }
    }
    
    func updateNotifications(){
        if let currentRec = self.currentRecord, hasSetNofifications{
            let date = Date()
            let hour = Calendar.current.component(.hour, from: date)
            let period = getTimePeriod(for: date)
            
            for timePeriod in TimePeriod.allCases{
                if UserDefaultsManager.getID(period: timePeriod) == nil{
                    scheduleNotification(for: timePeriod)
                }
            }
            
            
            if  (period == .Morning && hour < AppConstants.MORNING_NOTIFICATION_HOUR && currentRec.morningDate != nil) ||
                    (period == .Afternoon && hour < AppConstants.AFTERNOON_NOTIFICATION_HOUR && currentRec.eveningDate != nil) ||
                    (period == .Night && hour < AppConstants.NIGHT_NOTIFICATION_HOUR && currentRec.nightDate != nil){
                cancelSheduledNotification(for: period)
            }
        }
    }
    
    var hasSetNofifications:Bool{
        UserDefaultsManager.hasNotificationsScheduled()
    }
    
    func scheduleNotification(for period:TimePeriod){
        notificationManager.sheduleNotification(for: period) { identifier in
            if let id = identifier{
                UserDefaultsManager.setID(id: id, for: period)
                UserDefaultsManager.setNotificationTriggeredVal(isSet: true)
                Log("Scheduled notification for \(period.rawValue)")
            }
        }
    }
    
    func cancelSheduledNotification(for period:TimePeriod){
        if let id = UserDefaultsManager.getID(period: period){
            Log("Cancelling \(period.rawValue) Notification")
            notificationManager.cancelScheduledNotification(for: id)
            UserDefaultsManager.removeID(period: period)
        }
    }
}

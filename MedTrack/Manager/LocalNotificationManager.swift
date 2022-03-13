//
//  LocalNotificationManager.swift
//  MedTrack
//
//  Created by Sajith Konara on 2022-03-13.
//

import Foundation
import UserNotifications
import UIKit

class LocalNotificationManager{
    
    static let shared = LocalNotificationManager()
    
    private init(){}
    
    func requestAuthorization(onComplete:@escaping (Bool)->()){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge]) { granted, error in
            onComplete(granted)
            if let e = error{
                Log(e.localizedDescription)
            }
        }
    }
    
    func checkAuthorization(onComplete:@escaping (_ isAuthorized:Bool)->()){
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            onComplete(settings.authorizationStatus == .authorized)
        }
    }
    
    func getNotificationContent(for type:TimePeriod) -> (title:String,body:String){
        var title:String = ""
        var body:String = ""
        
        switch type {
        case .Morning:
            title = "Hey There, Good Morning! ☀️"
            body = "Just a friendly reminder to take your morning meds."
        case .Afternoon:
            title = "It's 💊 time"
            body = "Hey! It's time to take your afternoon pills"
        case .Night:
            title = "Hello again, 👋🏻"
            body = "Better to take your night meds now 😴"
        }
        
        return (title,body)
    }
    
    func sheduleNotification(for period:TimePeriod,onComplete:@escaping (_ identifier:String?)->()){
        
        let content = UNMutableNotificationContent()
        content.title = getNotificationContent(for: period).title
        content.body = getNotificationContent(for: period).body
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        switch period {
        case .Morning:
            dateComponents.hour = AppConstants.MORNING_NOTIFICATION_HOUR
        case .Afternoon:
            dateComponents.hour = AppConstants.AFTERNOON_NOTIFICATION_HOUR
        case .Night:
            dateComponents.hour = AppConstants.NIGHT_NOTIFICATION_HOUR
        }
        dateComponents.minute = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let uuid = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuid, content: content, trigger: trigger)
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { error in
            if let e = error{
                Log(e.localizedDescription)
                onComplete(nil)
            }else{
                onComplete(uuid)
            }
        }
        
    }
    
    func cancelScheduledNotification(for identifier:String){
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
    }
}

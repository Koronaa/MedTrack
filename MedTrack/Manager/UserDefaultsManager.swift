//
//  UserDefaultsManager.swift
//  MedTrack
//
//  Created by Sajith Konara on 2022-03-13.
//

import Foundation


enum UserDefaultsKey:String{
    case isNotificationsSet = "isNotificationsSet"
}

class UserDefaultsManager{
    
    private static func set(value val:Any?, for key:String){
        guard let val = val else {return}
        UserDefaults.standard.set(val, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    private static func getValue(forKey key:String) -> Any?{
        return UserDefaults.standard.value(forKey:key)
    }
    
    private static func removeValue(for key:String){
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    static func setID(id:String,for period:TimePeriod){
        set(value: id, for: period.rawValue)
    }
    
    static func getID(period:TimePeriod) -> String?{
        getValue(forKey: period.rawValue) as? String
    }
    
    static func removeID(period:TimePeriod){
        removeValue(for: period.rawValue)
    }
    
    static func setNotificationTriggeredVal(isSet:Bool){
        set(value: isSet, for: UserDefaultsKey.isNotificationsSet.rawValue)
    }
    
    static func hasNotificationsScheduled() ->Bool{
        getValue(forKey: UserDefaultsKey.isNotificationsSet.rawValue) as? Bool ?? false
    }
}

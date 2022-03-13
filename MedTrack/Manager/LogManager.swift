//
//  LogManager.swift
//  MedTrack
//
//  Created by Sajith Konara on 2022-03-13.
//

import Foundation

func Log(_ message:String, file:String = #file , calledBy:String = #function){
    let className = file.components(separatedBy: "/").last ?? ""
    print("LOG ==> \(className) ::: \(calledBy) ::: \(message)")
}

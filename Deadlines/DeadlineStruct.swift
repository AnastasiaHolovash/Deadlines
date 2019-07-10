//
//  DeadlineStruct.swift
//  Deadlines
//
//  Created by Головаш Анастасия on 7/9/19.
//  Copyright © 2019 Anastasia. All rights reserved.
//

import Foundation

struct Deadline {
    let name: String
    let date: Date
    let timeToComplete: TimeInterval
    let intDayToDeadline: Int
    
    var daysToDeadline: Int {
        print(">> \(Calendar.current.dateComponents([.day], from: Date(), to: date).day ?? 0)")
        if (Calendar.current.dateComponents([.day], from: Date(), to: date).day ?? -1) < 0{
            return Calendar.current.dateComponents([.day], from: Date(), to: date).day ?? -1
        }else{
            return (Calendar.current.dateComponents([.day], from: Date(), to: date).day ?? 0) + 1
        }
    }
}

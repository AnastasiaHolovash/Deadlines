//
//  DeadlineManager.swift
//  Deadlines
//
//  Created by Головаш Анастасия on 7/8/19.
//  Copyright © 2019 Anastasia. All rights reserved.
//

import Foundation
import Firebase

class DeadlineManager {

    static let shared = DeadlineManager()

    var deadlines = [Deadline]()
    
    func getDeadlines(completion: (([Deadline]) -> Void)?) {
        
        var tempDeadlines = [Deadline]()
        let uid = Auth.auth().currentUser?.uid
        let ref = Database.database().reference()
        
        ref.child("\(uid ?? "")/").observe(.value){ [weak self] (snapshot) in
            guard let dataFromDatabase = snapshot.value as? [String : [String: Int]] else {return}
            //print("DATA : \(dataFromDatabase)")
            //            var names: [String] = []
            //            var timeToComplete: [TimeInterval] = []
            //            var datesOfDeadline: [Date] = []
            //            var daysToDeadline: [Int] = []
            //            var intDatesOfDeadline: [Int] = []
            
            dataFromDatabase.forEach { (key, value) in
                
                let deadline = Deadline(name: key,
                                        date: Date(timeIntervalSince1970: TimeInterval(value["dateOfDeadline"] ?? 0)),
                                        timeToComplete: TimeInterval(value["requiredTimeToComplete"] ?? 0), intDayToDeadline: value["dateOfDeadline"] ?? 0)
                tempDeadlines.append(deadline)
            }
            guard let this = self else { return }
            this.deadlines = tempDeadlines
            tempDeadlines = []
            completion?(this.deadlines)

        }
        
        
//        let ref2 = Database.database().reference()
//        ref2.child("\(uid ?? "")/").observe(.childChanged){ [weak self] (snapshot) in
//            self?.deadlines = []
//            guard let dataFromDatabase = snapshot.value as? [String : [String: Int]] else {return}
//            //print("DATA : \(dataFromDatabase)")
//            //            var names: [String] = []
//            //            var timeToComplete: [TimeInterval] = []
//            //            var datesOfDeadline: [Date] = []
//            //            var daysToDeadline: [Int] = []
//            //            var intDatesOfDeadline: [Int] = []
//
//            dataFromDatabase.forEach { (key, value) in
//
//                let deadline = Deadline(name: key,
//                                        date: Date(timeIntervalSince1970: TimeInterval(value["dateOfDeadline"] ?? 0)),
//                                        timeToComplete: TimeInterval(value["requiredTimeToComplete"] ?? 0), intDayToDeadline: value["dateOfDeadline"] ?? 0)
//                tempDeadlines.append(deadline)
//            }
//            guard let this = self else { return }
//            this.deadlines = tempDeadlines
//            completion?(this.deadlines)
//
        }
        
        
    }


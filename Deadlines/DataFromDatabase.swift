//
//  DataFromDatabase.swift
//  Deadlines
//
//  Created by Головаш Анастасия on 7/7/19.
//  Copyright © 2019 Anastasia. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

func getData() -> [String : [String: Int]]{
    let uid = Auth.auth().currentUser?.uid
    let ref = Database.database().reference()
    var array: [String : [String: Int]] = [:]
    ref.child("\(uid ?? "")/").observe(.value){
        (snapshot) in guard let dataFromDatabase = snapshot.value as? [String : [String: Int]] else {return}
        //print("DATA : \(dataFromDatabase)")
        array = dataFromDatabase
    }
    return array
}

func getNames(data : [String : [String: Int]]) -> [String] {
    var names: [String] = []
    for oneDeadline in data{
        names.append(oneDeadline.key)
    }
    print("NAMES : \(names)")
    return names
}

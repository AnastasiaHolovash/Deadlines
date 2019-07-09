//
//  DetailViewController.swift
//  Deadlines
//
//  Created by Головаш Анастасия on 7/9/19.
//  Copyright © 2019 Anastasia. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var selectedDeadline: Deadline = Deadline(name: "", date: Date(timeIntervalSince1970:  0), timeToComplete: 0,  intDayToDeadline: 0)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

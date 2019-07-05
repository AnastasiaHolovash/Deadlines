//
//  AddDeadlineViewController.swift
//  Deadlines
//
//  Created by Головаш Анастасия on 7/4/19.
//  Copyright © 2019 Anastasia. All rights reserved.
//

import UIKit

class AddDeadlineViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var deadlineDatePicker: UIDatePicker!
    @IBOutlet weak var timeToCompletePicker: UIDatePicker!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveAction(_ sender: UIButton) {
        
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

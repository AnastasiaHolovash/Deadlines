//
//  SettingsViewController.swift
//  Deadlines
//
//  Created by Denis on 7/5/19.
//  Copyright © 2019 Anastasia. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI
import GoogleSignIn

class SettingsTableViewController: UITableViewController {

//    var isDatePickerNeeded = false
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var timeIntervalTextField: UITextField!
    private var datePicker: UIDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let email = Auth.auth().currentUser?.email else { return }
        emailLabel.text = email
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SettingsTableViewController.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .countDownTimer
        datePicker?.minuteInterval = 15
        timeIntervalTextField.inputView = datePicker
        datePicker?.addTarget(self, action: #selector(SettingsTableViewController.dateChanged(datePicker:)), for: .valueChanged)
        
//        tableView.register(UINib(nibName: "DatePickerTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "timeIntervalPickerCell")
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        let min = Int(datePicker.countDownDuration / 60)
        let hours = Int(min / 60)
        timeIntervalTextField.text = String("\(hours) hours \(min - hours * 60) min")
        view.endEditing(true)
    }
    
    @IBAction func didPressExit(_ sender: UIButton) {
        do {
            Settings.shared.isLoggedIn = false
            try Auth.auth().signOut()
            GIDSignIn.sharedInstance()?.signOut()
            
            emailLabel.text = "Email:"
            ViewManager.shared.setupInitialController()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if !isDatePickerNeeded, indexPath.row == 3 {
//            isDatePickerNeeded = true
//            let lastItemIndexPath = IndexPath(row: indexPath.row + 1, section: indexPath.section)
//            tableView.insertRows(at: [lastItemIndexPath], with: .automatic)
//        }
////        else if isDatePickerNeeded {
////            isDatePickerNeeded = false
////            let lastIndexPath = IndexPath(row: cars.count, section: indexPath.section)
////            tableView.deleteRows(at: [lastIndexPath], with: .automatic)
////        }
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if isDatePickerNeeded, let cell = tableView.dequeueReusableCell(withIdentifier: "datePickerCell") as? DatePickerTableViewCell
//        {
//            //cell.delegate = self
//            return  cell
//        }
//        return tableView.
//    }
    
    



}

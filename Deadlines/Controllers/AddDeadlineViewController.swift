//
//  AddDeadlineViewController.swift
//  Deadlines
//
//  Created by Головаш Анастасия on 7/4/19.
//  Copyright © 2019 Anastasia. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class AddDeadlineViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
//    @IBOutlet weak var deadlineDatePicker: UIDatePicker!
    @IBOutlet weak var deadlineTextField: UITextField!
//    @IBOutlet weak var timeToCompletePicker: UIDatePicker!
    @IBOutlet weak var timeToCompleteTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    
    let calendar = Calendar.current
    
    private var datePicker: UIDatePicker?
    private var timePicker: UIDatePicker?
    var dateOfDeadline: Date = Date()
    var timeToCompleteDuration: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboard()
        
        // datePicker
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(AddDeadlineViewController.dateChanged(datePicker:)), for: .valueChanged)
        deadlineTextField.inputView = datePicker
        
        //timePicker
        timePicker = UIDatePicker()
        timePicker?.datePickerMode = .countDownTimer
        timePicker?.minuteInterval = 15
        timePicker?.addTarget(self, action: #selector(AddDeadlineViewController.timeChanged(timePicker:)), for: .valueChanged)
        timeToCompleteTextField.inputView = timePicker
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AddDeadlineViewController.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        
        dateOfDeadline = previousDay() 
        
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        deadlineTextField.text = dateFormatter.string(from: datePicker.date)
        dateOfDeadline = datePicker.date
        view.endEditing(true)
    }
    
    @objc func timeChanged(timePicker: UIDatePicker) {
        let min = Int(timePicker.countDownDuration / 60)
        let hours = Int(min / 60)
        timeToCompleteTextField.text = String("\(hours) hours \(min - hours * 60) min")

        timeToCompleteDuration = timePicker.countDownDuration
        view.endEditing(true)
    }
    
    func previousDay() -> Date{
        let currentDate = Date()
        return calendar.date(byAdding: .day, value: -1, to: currentDate) ?? currentDate
    }
    
    func previousDayInt() -> Int {
        let currentDate = Date()
        let previousDay = Int(calendar.date(byAdding: .day, value: -1, to: currentDate)?.timeIntervalSince1970 ?? currentDate.timeIntervalSince1970)
        return previousDay
    }
    
    @IBAction func saveAction(_ sender: UIButton) {
        guard let name = nameTextField.text else { return }
        let getdateOfDeadline = dateOfDeadline
        let requiredTimeToCompleteDuration = timeToCompleteDuration
        // Date -> Int
        let dateOfDeadlineTimeInterval = getdateOfDeadline.timeIntervalSince1970
        let dateOfDeadline = Int(dateOfDeadlineTimeInterval)
        // Duration -> Int
        let requiredTimeToComplete = Int(requiredTimeToCompleteDuration)
        
        if !name.isEmpty && (dateOfDeadline > previousDayInt()){
            let uid = Auth.auth().currentUser?.uid
            let ref = Database.database().reference()
            ref.child("\(uid ?? "")/\(name)").setValue(["dateOfDeadline" : dateOfDeadline, "requiredTimeToComplete" : requiredTimeToComplete])
            //showSavedAlert()
            //navigationController?.popViewController(animated: true)
            navigationController?.popToRootViewController(animated: true)
            //navigationController?.popViewController(animated: true)
            //show(TimeLeftViewController, sender: Any)
        }else{
            showErrorAlert()
        }
        
    }
    //NEED APDATING======
    func showErrorAlert() {
        let alert = UIAlertController(title: "Error", message: "Enter all, please", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    func showSavedAlert() {
        let alert = UIAlertController(title: "", message: "New deadline is saved", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
        
        navigationController?.popViewController(animated: true)
        //navigationController?.popToRootViewController(animated: true)
    }
    
}
extension UIViewController {
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

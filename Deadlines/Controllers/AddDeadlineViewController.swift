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
    @IBOutlet weak var deadlineDatePicker: UIDatePicker!
    @IBOutlet weak var timeToCompletePicker: UIDatePicker!
    @IBOutlet weak var saveButton: UIButton!
    
    let calendar = Calendar.current
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //======================
        
//        var dateComponents = DateComponents()
//        dateComponents.year = 2019
//        dateComponents.month = 7
//        dateComponents.day = 20
//        guard let date = calendar.date(from: dateComponents) else { return  }
//
//        let someInt = 5
        //======================

        //print("DATE = \(date)")
//        let timeInterval = date.timeIntervalSince1970
//        let intTimeInterval = Int(timeInterval)
//
//        let uid = Auth.auth().currentUser?.uid
//        let ref = Database.database().reference()
//        //ref.child("\(uid ?? "")/name").setValue("NewNew")
//        ref.child("\(uid ?? "")/NewNew").setValue(["dateOfDeadline" : intTimeInterval, "requiredTimeToComplete" : someInt])
//        ref.child("\(uid ?? "")/NewNew/dateOfDeadline/").observe(.value){
//            (snapshot) in guard let dateOfDeadline = snapshot.value as? Int else {return}
//            print("dateOfDeadline : \(dateOfDeadline)")
//
//        }
        //let myNSDate = Date(timeIntervalSince1970: timeInterval)
        self.hideKeyboard()

    }
    func previousDayInt() -> Int {
        let currentDate = Date()
        let previousDay = Int(calendar.date(byAdding: .day, value: -1, to: currentDate)?.timeIntervalSince1970 ?? currentDate.timeIntervalSince1970)
        return previousDay
    }
    
    @IBAction func saveAction(_ sender: UIButton) {
        guard let name = nameTextField.text else { return }
        let getdateOfDeadline = deadlineDatePicker.date
        let requiredTimeToCompleteDuration = timeToCompletePicker.countDownDuration
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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

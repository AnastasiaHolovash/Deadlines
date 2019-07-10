//
//  DetailViewController.swift
//  Deadlines
//
//  Created by Головаш Анастасия on 7/9/19.
//  Copyright © 2019 Anastasia. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class DetailViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var daysLeftLabel: UILabel!
    
    var selectedDeadline: Deadline = Deadline(name: "", date: Date(timeIntervalSince1970:  0), timeToComplete: 0,  intDayToDeadline: 0)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.text = selectedDeadline.name
        dateTextField.text = dateToString(date: selectedDeadline.date)
        timeTextField.text = timeToCompleteInString(period: selectedDeadline.timeToComplete)
        if selectedDeadline.daysToDeadline < 0{
            daysLeftLabel.text = "Deadline was missed \(selectedDeadline.daysToDeadline * (-1) + 1) days ago"
            daysLeftLabel.textColor = .red
        }else{
            daysLeftLabel.text = "\(selectedDeadline.daysToDeadline) days left"
        }
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didPressEdit(_ sender: UIButton) {
        
    }
    
    @IBAction func didPressDelete(_ sender: Any) {
        showAreYouSureAlert()
    }
    
    func dateToString(date : Date) -> String {
        let dateDateFormater = DateFormatter()
        dateDateFormater.dateFormat = "yyyy-MM-dd"
        return dateDateFormater.string(from: date)
    }
    func timeToCompleteInString(period: TimeInterval) -> String {
        let min = Int(period / 60)
        let hours = Int(min / 60)
        return "\(hours) hours \(min - hours * 60) min"
    }
    
    func showAreYouSureAlert() {
        let alert = UIAlertController(title: "", message: "Are you sure that you want to delete this deadline??", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (action) in
            let uid = Auth.auth().currentUser?.uid
            let ref = Database.database().reference()
            ref.child("\(uid ?? "")/\(self.selectedDeadline.name)").removeValue()
            self.navigationController?.popToRootViewController(animated: true)
            //DeadlineManager.shared.getDeadlines()
        }))
//        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: nil))
        present(alert, animated: true, completion: nil)
    }


}

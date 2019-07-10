//
//  ViewController.swift
//  Deadlines
//
//  Created by Головаш Анастасия on 6/24/19.
//  Copyright © 2019 Anastasia. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ForTodayViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var deadlines: [Deadline] = []
    
    //------------------------------------
    var selectedDeadlines: [Deadline] = []
    var proponedTime: [Int] = []
    var needAlert = false
    var checkedOut: [Deadline] = []
    var editedDeadlines: [Deadline] = []

    //------------------------------------

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "customCell")
        
        updateDeadlines()
        
//        selectorDealines()
//        print("""
//
//            *********************************************
//
//            deadlines: \(deadlines)
//            selectedDeadlines:\(selectedDeadlines)
//            proponedTime: \(proponedTime)
//            """)
        
    
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        let uid = Auth.auth().currentUser?.uid
        let ref = Database.database().reference()
        ref.child("\(uid ?? "")/").observe(.childChanged){ deadline in
            self.tableView.reloadData()
        }
    }
    
    
    
    func updateDeadlines() {
        DeadlineManager.shared.getDeadlines { [weak self] deadlines in
            guard let this = self else { return }
            this.deadlines = deadlines
            
            this.selectorDealines()
            print("""
                
                *********************************************
                
                deadlines: \(deadlines)
                selectedDeadlines:\(String(describing: this.selectedDeadlines))
                proponedTime: \(String(describing: this.proponedTime))
                """)
            
            this.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let swipeEdit = UIContextualAction(style: .normal, title: "Edit spent time") { (action, view, success) in
            print("Edit swipe")
        }
        swipeEdit.image = #imageLiteral(resourceName: "icons8-edit")
        swipeEdit.backgroundColor = #colorLiteral(red: 0.4780259329, green: 0.304431371, blue: 0.8418662754, alpha: 0.2978649401)
        return UISwipeActionsConfiguration(actions: [swipeEdit])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let swipeDelete = UIContextualAction(style: .normal, title: "Delete") { (action, view, success) in
            print("Delete swipe")
        }
        swipeDelete.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 0.6473672945)
        return UISwipeActionsConfiguration(actions: [swipeDelete])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedDeadlines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as? CustomTableViewCell
            else {return UITableViewCell()}
        
        cell.nameLabel.text = selectedDeadlines[indexPath.row].name
        cell.showDeadlineLabel.text = dateToString(date: selectedDeadlines[indexPath.row].date)
        cell.proposedTimeLabel.text = timeToCompleteInString(period: selectedDeadlines[indexPath.row].timeToComplete)

        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 98
    }
    
    func dateToString(date : Date) -> String {
        let dateDateFormater = DateFormatter()
        dateDateFormater.dateFormat = "yyyy-MM-dd"
        return dateDateFormater.string(from: date)
    }
    
    func timeToCompleteInString(period: TimeInterval) -> String {
        let min = Int(period / 60)
        let hours = Int(min / 60)
        return "\(hours) hours \(min - hours * 60) min should spend for this one today"
    }

    

    //showDetailFromForToday
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Mark: - pushing information about selected
        guard (storyboard?.instantiateViewController(withIdentifier: "detailViewController") as? DetailViewController) != nil else { return }
        performSegue(withIdentifier: "showDetailFromForToday", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showDetailFromForToday" {
            if let indexPath = tableView.indexPathForSelectedRow {
                if let destination = segue.destination as? DetailViewController {
                    destination.selectedDeadline = selectedDeadlines[indexPath.row]
                }
            }
        }
    }
    
    
    
    func selectorDealines(){
        //var deadlinesNew = deadlines
//        var selectedDeadlines: [Deadline] = []
//        var proponedTime: [Int] = []
//        var needAlert = false
        var timeForWork = 3 * 60
        editedDeadlines = deadlines
        
        for oneDeadline in deadlines{
            if Calendar.current.dateComponents([.year, .month, .day], from: oneDeadline.date) == Calendar.current.dateComponents([.year, .month, .day], from: Date()){
                timeForWork -= Int(oneDeadline.timeToComplete / 60)
                selectedDeadlines.append(oneDeadline)
                removeDeadline(deadlineToRemove: oneDeadline)
                //checkedOut.append(oneDeadline)
                //deadlinesNew.remove(at: oneDeadline)
                proponedTime.append(Int(oneDeadline.timeToComplete / 60))
            }
            if timeForWork < 0 {
                needAlert = true
            } else if timeForWork > 0{
                
                // Search the deadline for the next day that has the bigest timeToComplete
                var tempArray: [Deadline] = []
                for oneDeadline in deadlines{
                    if Calendar.current.dateComponents([.year, .month, .day], from: oneDeadline.date) == Calendar.current.dateComponents([.year, .month, .day], from: nextDay(currentDate: Date())){
                        tempArray.append(oneDeadline)
                    }
                }
                
                if !tempArray.isEmpty {
                    var theBigestForTomorrow = tempArray[0]
                    for oneDeadline in tempArray{
                        if Int(oneDeadline.timeToComplete) > Int(theBigestForTomorrow.timeToComplete){
                            theBigestForTomorrow = oneDeadline
                        }
                    }
                    
                    timeForWork -= howMuchTimeToSpend(timeLeft: timeForWork, oneDeadline: theBigestForTomorrow)
//                    if timeForWork >= Int(theBigestForTomorrow.timeToComplete / 60){
//                        timeForWork -= Int(theBigestForTomorrow.timeToComplete / 60)
//                        proponedTime.append(Int(theBigestForTomorrow.timeToComplete / 60))
//                    }else{
//                        timeForWork = 0
//                        proponedTime.append(timeForWork)
//                    }
//                    selectedDeadlines.append(theBigestForTomorrow)
                }
                
                // Search deadlines that have the bigest timeToComplete
                var editedDeadlines = deadlines
                
                while timeForWork > 0{
                    if checkedOut.count == deadlines.count{
                        break
                    }
                    var theBigest = deadlines[0]
                    for one in deadlines{
                        if Int(one.timeToComplete) > Int(theBigest.timeToComplete){
                            theBigest = one
                        }
                    }
                    var nameOfDeadlines: [String] = []
                    editedDeadlines.forEach { (deadline) in
                        nameOfDeadlines.append(deadline.name)
                    }
                    
                    if nameOfDeadlines.contains(theBigest.name) {
                        if let idx = nameOfDeadlines.firstIndex(of: theBigest.name) {
                            editedDeadlines.remove(at: idx)
                        }
                    }
                    print(editedDeadlines)
                    //editedDeadlines.remove()
                    
                    var theSame = false
                    for oneChecked in checkedOut{
                        if theBigest.name == oneChecked.name{
                            theSame = true
                        }
                    }
                    if !theSame{
                        timeForWork -= howMuchTimeToSpend(timeLeft: timeForWork, oneDeadline: theBigest)
                    }
                    checkedOut.append(theBigest)
                }
                
                
            }
        }
        
        //return selectedDeadlines
    }
    
    func nextDay(currentDate: Date) -> Date {
        guard let nextDayDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate) else { return currentDate }
        return nextDayDate
    }
    // timeLeft in minutes
    func howMuchTimeToSpend(timeLeft: Int, oneDeadline: Deadline) -> Int {
        var howMuchTimeToSpend = 0
        if timeLeft >= Int(oneDeadline.timeToComplete / 60){
            howMuchTimeToSpend = Int(oneDeadline.timeToComplete / 60)
            proponedTime.append(howMuchTimeToSpend)
        }else{
            howMuchTimeToSpend = timeLeft
            proponedTime.append(howMuchTimeToSpend)
        }
        selectedDeadlines.append(oneDeadline)
        checkedOut.append(oneDeadline)
        return howMuchTimeToSpend
    }
    
    func removeDeadline(deadlineToRemove: Deadline) {
        var nameOfDeadlines: [String] = []
        editedDeadlines.forEach { (deadline) in
            nameOfDeadlines.append(deadline.name)
        }
        
        if nameOfDeadlines.contains(deadlineToRemove.name) {
            if let idx = nameOfDeadlines.firstIndex(of: deadlineToRemove.name) {
                self.editedDeadlines.remove(at: idx)
            }
        }
        nameOfDeadlines = []
    }
    


}


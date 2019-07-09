//
//  ViewController.swift
//  Deadlines
//
//  Created by Головаш Анастасия on 6/24/19.
//  Copyright © 2019 Anastasia. All rights reserved.
//

import UIKit

class ForTodayViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var deadlines: [Deadline] = []

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "customCell")
        
        DeadlineManager.shared.getDeadlines { [weak self] deadlines in
            guard let this = self else { return }
            this.deadlines = deadlines
            this.tableView.reloadData()
        }
        
        //tableView.isEditing = true
    
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
        return deadlines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as? CustomTableViewCell
            else {return UITableViewCell()}
        
        cell.nameLabel.text = deadlines[indexPath.row].name
        cell.showDeadlineLabel.text = dateToString(date: deadlines[indexPath.row].date)
        cell.proposedTimeLabel.text = timeToCompleteInString(period: deadlines[indexPath.row].timeToComplete)


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


}


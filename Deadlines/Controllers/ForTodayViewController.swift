//
//  ViewController.swift
//  Deadlines
//
//  Created by Головаш Анастасия on 6/24/19.
//  Copyright © 2019 Anastasia. All rights reserved.
//

import UIKit

class ForTodayViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //private let numberOfRows = 3
    public let data = ["Fitst task", "Second task", "Third task"]

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "customCell")
    
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as? CustomTableViewCell
            else {return UITableViewCell()}
        
        cell.nameLabel.text = data[indexPath.row]
        //cell.accessoryType = UITableViewCell.AccessoryType(rawValue: 4) ?? .none

        return cell
    }
   
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
//        cell.textLabel?.text = data[indexPath.row]
//        return cell
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 98
    }


}


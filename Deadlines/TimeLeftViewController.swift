//
//  TimeLeftViewController.swift
//  Deadlines
//
//  Created by Головаш Анастасия on 6/29/19.
//  Copyright © 2019 Anastasia. All rights reserved.
//

import UIKit

class TimeLeftViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    @IBOutlet weak var horizontalScrollView: UIScrollView!
    //@IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewWidth: NSLayoutConstraint!
    
    //Data
    let arrayOfNames = ["Fitst task", "Second task", "Third task", "Fitst task", "Second task", "Third task", "Fitst task", "Second task", "Third task", "Fitst task", "Second task", "Third task"]
    let arrayOfRequiredTimeToComplete = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    let arrayOfColors: [UIColor] = [.red, .blue, .yellow, .red, .blue, .yellow, .red, .blue, .yellow, .red, .blue, .yellow]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let calendar = Calendar.current
        
        // Curent day
        let dayDateFormater = DateFormatter()
        dayDateFormater.dateFormat = "yyyy-MM-dd"
        let dateNow = dayDateFormater.string(from: Date())
        print("today : \(dateNow)")
        
        // Day Of Deadline
        var dateComponents = DateComponents()
        dateComponents.year = 2019
        dateComponents.month = 7
        dateComponents.day = 20
        guard let date = calendar.date(from: dateComponents) else { return  }
        
        //let makeAProject = Deadline(name: "Make a project", date: date)
        
//        // weekDay
//        let weekdayDateFormatter = DateFormatter()
//        weekdayDateFormatter.dateFormat = "EEE"
//        let weekday = weekdayDateFormatter.string(from: makeAProject.date)
//        // day + month
//        let monthDateFormater =  DateFormatter()
//        monthDateFormater.dateFormat = "d MMMM"
//        let month = monthDateFormater.string(from: makeAProject.date)
//        print("weekday : \(weekday)")
//        print("month : \(month)")
//
//        let tomorrow = nextDay(calendar: calendar, currentDate: Date())
//        let tomorrowDayString = dayDateFormater.string(from: tomorrow)
//        print("tomorrow : \(tomorrowDayString)")
//        let DLDateString = dayDateFormater.string(from: makeAProject.date)
//        print("DLDate : \(DLDateString)")
//
//        if calendar.dateComponents([.year, .month, .day], from: tomorrow) == calendar.dateComponents([.year, .month, .day], from: date){
//            print("YES")
//        }
//
//        if tomorrowDayString == DLDateString{
//            print("It`s the same date")
//        }else{
//            print("It`s NOT the same date")
//        }
        
        //setupView(stackView: createTwoCellsStackView(weekday: "Mon", dayWithMonth: "30 June"))
        
        //TableView
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "TimeLeftTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "timeLeftCell")
        
        let horizontalStackView = createHorisontalStackViewWithDates(calendar: calendar, theLastDate: date)
        setupStackView(stackView: horizontalStackView)
        
        
        


        
    }
    
    func createTwoCellsStackView(weekday: String, dayWithMonth: String) -> UIStackView {
        
        let lbl1 = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 35))
        let lbl2 = UILabel(frame: CGRect(x: 0, y: 35, width: 100, height: 35))
        lbl1.text = weekday
        lbl1.textAlignment = .center
        lbl2.text = dayWithMonth
        lbl2.textAlignment = .center
        
        let stackView: UIStackView = {
            let sv = UIStackView(arrangedSubviews: [lbl1, lbl2])
            //sv.translatesAutoresizingMaskIntoConstraints = false
            sv.axis = .vertical
            //sv.bounds = CGRect(x: 0, y: 0, width: 70, height: 80)                   //Change nothing
            sv.spacing = 10
            sv.distribution = .fillEqually
//            sv.heightAnchor.constraint(equalTo: horizontalScrollView.heightAnchor - tableView.heightAnchor, multiplier: 1.0)
            return sv
        }()
        
        return stackView
    }
    
//    func createArraysOfWeekdays(calendar: Calendar,theLastDate: Date) -> [String] {
//        <#function body#>
//    }
//    
//    func createArraysOfDays(calendar: Calendar,theLastDate: Date) -> [String] {
//        <#function body#>
//    }
    
    func createHorisontalStackViewWithDates(calendar: Calendar,theLastDate: Date) -> UIStackView{
        var currentDay = Date()
        var arrayOfWeekdays: [String] = []          //only for printing
        var arrayOfDaysWithMonths: [String] = []    //only for printing
        var arrayOfTwoCellsStackView: [UIStackView] = []
        
        // weekDay formating
        let weekdayDateFormatter = DateFormatter()
        weekdayDateFormatter.dateFormat = "EEE"
        
        // day + month formating
        let monthDateFormater =  DateFormatter()
        monthDateFormater.dateFormat = "d MMM"
        
        while calendar.dateComponents([.year, .month, .day], from: currentDay) != calendar.dateComponents([.year, .month, .day], from: theLastDate) {
            
            arrayOfWeekdays.append(weekdayDateFormatter.string(from: currentDay))    //only for printing
            arrayOfDaysWithMonths.append(monthDateFormater.string(from: currentDay)) //only for printing
            
            let newStackView = createTwoCellsStackView(weekday: weekdayDateFormatter.string(from: currentDay), dayWithMonth: monthDateFormater.string(from: currentDay))
            arrayOfTwoCellsStackView.append(newStackView)
            
            currentDay = nextDay(calendar: calendar, currentDate: currentDay)
            
        }
        if calendar.dateComponents([.year, .month, .day], from: currentDay) == calendar.dateComponents([.year, .month, .day], from: theLastDate){
            arrayOfWeekdays.append(weekdayDateFormatter.string(from: currentDay))    //only for printing
            arrayOfDaysWithMonths.append(monthDateFormater.string(from: currentDay)) //only for printing
            
            let newStackView = createTwoCellsStackView(weekday: weekdayDateFormatter.string(from: currentDay), dayWithMonth: monthDateFormater.string(from: currentDay))
            arrayOfTwoCellsStackView.append(newStackView)
        }
        
        let stackView: UIStackView = {
            let sv = UIStackView(arrangedSubviews: arrayOfTwoCellsStackView)
            sv.translatesAutoresizingMaskIntoConstraints = false
            sv.axis = .horizontal
            sv.spacing = 10
            //sv.bounds = CGRect(x: 0, y: 0, width: arrayOfTwoCellsStackView.count * 50, height: 80) //Change nothing
            sv.distribution = .fillEqually
            return sv
        }()
        
        print(arrayOfWeekdays)
        print(arrayOfDaysWithMonths)
        print("arrayOfTwoCellsStackView.count = \(arrayOfTwoCellsStackView.count)")
        return stackView
        
    }
    
    fileprivate func setupStackView(stackView: UIStackView){
        
        horizontalScrollView.addSubview(stackView)
        
//        let pinLeftStackView = NSLayoutConstraint(item: stackView, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: horizontalScrollView, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1.0, constant: 0.0)
        
//        let pinRightStackView = NSLayoutConstraint(item: stackView, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: horizontalScrollView, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1.0, constant: 0.0)
        
        let pinTopStackView = NSLayoutConstraint(item: stackView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: horizontalScrollView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 10.0)
        
//        let pinBottomStackView = NSLayoutConstraint(item: stackView, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: tableView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 0.0)
        
//        let heightStackView = NSLayoutConstraint(item: stackView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: horizontalScrollView, attribute: NSLayoutConstraint.Attribute.height, multiplier: 0.15, constant: 0.0)
        
        horizontalScrollView.addConstraints([pinTopStackView])
        
//        let wighthScrollView = NSLayoutConstraint(item: horizontalScrollView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: stackView, attribute: NSLayoutConstraint.Attribute.width, multiplier: 0.1, constant: 0.0)
//
//        self.view.addConstraints([wighthScrollView])
        
        print("horizontalScrollView.frame.width = " + "\(horizontalScrollView.frame.width)")
        print("stackView.frame.width =  \(stackView.frame.width)")
        //tableViewWidth.constant = horizontalScrollView.frame.width
        //tableViewWidth.constant = stackView.frame.width
        print("horizontalScrollView.frame.width = " + "\(horizontalScrollView.frame.width)")
        print("stackView.frame.width =  \(stackView.frame.width)")


    }
    
    
    func nextDay(calendar: Calendar,currentDate: Date) -> Date {
        guard let nextDayDate = calendar.date(byAdding: .day, value: 1, to: currentDate) else { return currentDate }
        return nextDayDate
    }
    
    //========TABLE VIEW==========
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
//
//        cell.backgroundColor = arrayOfColors[indexPath.row]
//        cell.textLabel?.text = arrayOfNames[indexPath.row]
        //cell.subtit = "\(arrayOfRequiredTimeToComplete[indexPath.row])"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "timeLeftCell", for: indexPath) as? TimeLeftTableViewCell
            else {return UITableViewCell()}
        cell.nameLabel.text = arrayOfNames[indexPath.row]
        cell.colorView.backgroundColor = arrayOfColors[indexPath.row]
        cell.viewWidth.constant = CGFloat(arrayOfRequiredTimeToComplete[indexPath.row] * 56)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
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

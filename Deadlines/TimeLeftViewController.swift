//
//  TimeLeftViewController.swift
//  Deadlines
//
//  Created by Головаш Анастасия on 6/29/19.
//  Copyright © 2019 Anastasia. All rights reserved.
//

import UIKit

class TimeLeftViewController: UIViewController {

    @IBOutlet weak var horizontalScrollView: UIScrollView!
    //@IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableView: UITableView!
    
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
        dateComponents.day = 15
        guard let date = calendar.date(from: dateComponents) else { return  }
        
        let makeAProject = Deadline(name: "Make a project", date: date)
        
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
        
        let horizontalStackView = createHorisontalStackViewWithDates(calendar: calendar, theLastDate: date)
        setupStackView(stackView: horizontalStackView)


        
    }
    
    func createTwoCellsStackView(weekday: String, dayWithMonth: String) -> UIStackView {
        
        let lbl1 = UILabel(frame: CGRect(x: 0, y: 0, width: 70, height: 25))
        let lbl2 = UILabel(frame: CGRect(x: 0, y: 25, width: 70, height: 25))
        lbl1.text = weekday
        lbl2.text = dayWithMonth
        
        let stackView: UIStackView = {
            let sv = UIStackView(arrangedSubviews: [lbl1, lbl2])
            //sv.translatesAutoresizingMaskIntoConstraints = false
            sv.axis = .vertical
            sv.bounds = CGRect(x: 0, y: 0, width: 70, height: 50)
            sv.spacing = 1
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
        
        // weekDay
        let weekdayDateFormatter = DateFormatter()
        weekdayDateFormatter.dateFormat = "EEE"
        
        // day + month
        let monthDateFormater =  DateFormatter()
        monthDateFormater.dateFormat = "d MMM"
        
        while calendar.dateComponents([.year, .month, .day], from: currentDay) != calendar.dateComponents([.year, .month, .day], from: theLastDate) {
            
            arrayOfWeekdays.append(weekdayDateFormatter.string(from: currentDay))    //only for printing
            arrayOfDaysWithMonths.append(monthDateFormater.string(from: currentDay)) //only for printing
            
            let newStackView = createTwoCellsStackView(weekday: weekdayDateFormatter.string(from: currentDay), dayWithMonth: monthDateFormater.string(from: currentDay))
            arrayOfTwoCellsStackView.append(newStackView)
            
            currentDay = nextDay(calendar: calendar, currentDate: currentDay)
            
            
        }
        
        let stackView: UIStackView = {
            let sv = UIStackView(arrangedSubviews: arrayOfTwoCellsStackView)
            sv.translatesAutoresizingMaskIntoConstraints = false
            sv.axis = .horizontal
            sv.spacing = 10
            sv.bounds = CGRect(x: 0, y: 0, width: arrayOfTwoCellsStackView.count * 80, height: 50)
            sv.distribution = .fillEqually
            return sv
        }()
        
        print(arrayOfWeekdays)
        print(arrayOfDaysWithMonths)
        
        return stackView
        
    }
    
    fileprivate func setupStackView(stackView: UIStackView){
        
        horizontalScrollView.addSubview(stackView)
        
//        let pinLeftStackView = NSLayoutConstraint(item: stackView, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: horizontalScrollView, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1.0, constant: 0.0)
        
//        let pinRightStackView = NSLayoutConstraint(item: stackView, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: horizontalScrollView, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1.0, constant: 0.0)
        
        let pinTopStackView = NSLayoutConstraint(item: stackView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: horizontalScrollView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 0.0)
        
//        let pinBottomStackView = NSLayoutConstraint(item: stackView, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: tableView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 0.0)
        
        let heightStackView = NSLayoutConstraint(item: stackView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: horizontalScrollView, attribute: NSLayoutConstraint.Attribute.height, multiplier: 0.15, constant: 0.0)
        
        horizontalScrollView.addConstraints([pinTopStackView, heightStackView])
        
//        let wighthScrollView = NSLayoutConstraint(item: horizontalScrollView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: stackView, attribute: NSLayoutConstraint.Attribute.width, multiplier: 0.1, constant: 0.0)
//
//        self.view.addConstraints([wighthScrollView])


    }
    
    
    func nextDay(calendar: Calendar,currentDate: Date) -> Date {
        guard let nextDayDate = calendar.date(byAdding: .day, value: 1, to: currentDate) else { return currentDate }
        return nextDayDate
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

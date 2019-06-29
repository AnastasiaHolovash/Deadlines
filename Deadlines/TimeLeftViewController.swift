//
//  TimeLeftViewController.swift
//  Deadlines
//
//  Created by Головаш Анастасия on 6/29/19.
//  Copyright © 2019 Anastasia. All rights reserved.
//

import UIKit

class TimeLeftViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let calendar = Calendar.current
        
        // Curent day
        //let dateNow = Date()
        let dayDateFormater = DateFormatter()
        dayDateFormater.dateFormat = "yyyy-MM-dd"
        let dateNow = dayDateFormater.string(from: Date())
        print("today : \(dateNow)")
        
        // Day Of Deadline
        var dateComponents = DateComponents()
        dateComponents.year = 2019
        dateComponents.month = 7
        dateComponents.day = 5
        guard let date = calendar.date(from: dateComponents) else { return  }
        
        let makeAProject = Deadline(name: "Make a project", date: date)
        
        // weekDay
        let weekdayDateFormatter = DateFormatter()
        weekdayDateFormatter.dateFormat = "EEE"
        let weekday = weekdayDateFormatter.string(from: makeAProject.date)
        // day + month
        let monthDateFormater =  DateFormatter()
        monthDateFormater.dateFormat = "d MMMM"
        let month = monthDateFormater.string(from: makeAProject.date)
        print("weekday : \(weekday)")
        print("month : \(month)")
        
        let tomorrow = nextDay(calendar: calendar, currentDate: Date())
        let tomorrowDayString = dayDateFormater.string(from: tomorrow)
        print("tomorrow : \(tomorrowDayString)")
        let DLDateString = dayDateFormater.string(from: makeAProject.date)
        print("DLDate : \(DLDateString)")
        
        if calendar.dateComponents([.year, .month, .day], from: tomorrow) == calendar.dateComponents([.year, .month, .day], from: date){
            print("YES")
        }
        
        if tomorrowDayString == DLDateString{
            print("It`s the same date")
        }else{
            print("It`s NOT the same date")
        }
        
        //setupView(stackView: createTwoCellsStackView(weekday: "Mon", dayWithMonth: "30 June"))
        createHorisontalStackViewWithDates(calendar: calendar, theLastDate: date)


        
    }
    func createTwoCellsStackView(weekday: String, dayWithMonth: String) -> UIStackView {
        let lbl1 = UILabel(frame: CGRect(x: 0, y: 0, width: 70, height: 25))
        let lbl2 = UILabel(frame: CGRect(x: 0, y: 25, width: 70, height: 25))
        lbl1.text = weekday
        lbl2.text = dayWithMonth
        
        let stackView: UIStackView = {
            let sv = UIStackView(arrangedSubviews: [lbl1, lbl2])
            sv.translatesAutoresizingMaskIntoConstraints = false
            sv.axis = .vertical
            sv.distribution = .fillEqually
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
        var arrayOfWeekdays: [String] = []
        var arrayOfDaysWithMonths: [String] = []
        var arrayOfTwoCellsStackView: [UIStackView] = []
        
        // weekDay
        let weekdayDateFormatter = DateFormatter()
        weekdayDateFormatter.dateFormat = "EEE"
        
        // day + month
        let monthDateFormater =  DateFormatter()
        monthDateFormater.dateFormat = "d MMMM"
        
        while calendar.dateComponents([.year, .month, .day], from: currentDay) != calendar.dateComponents([.year, .month, .day], from: theLastDate) {
            
            arrayOfWeekdays.append(weekdayDateFormatter.string(from: currentDay))
            arrayOfDaysWithMonths.append(monthDateFormater.string(from: currentDay))
            
            let newStackView = createTwoCellsStackView(weekday: weekdayDateFormatter.string(from: currentDay), dayWithMonth: monthDateFormater.string(from: currentDay))
            arrayOfTwoCellsStackView.append(newStackView)
            
            currentDay = nextDay(calendar: calendar, currentDate: currentDay)
            
            
        }
        
        let stackView: UIStackView = {
            let sv = UIStackView(arrangedSubviews: arrayOfTwoCellsStackView)
            sv.translatesAutoresizingMaskIntoConstraints = false
            sv.axis = .horizontal
            sv.distribution = .fillEqually
            return sv
        }()
        
        print(arrayOfWeekdays)
        print(arrayOfDaysWithMonths)
        
        return stackView
        
    }
    
    fileprivate func setupStackView(stackView: UIStackView){
        view.addSubview(stackView)

        NSLayoutConstraint.activate(<#[NSLayoutConstraint]#>)

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

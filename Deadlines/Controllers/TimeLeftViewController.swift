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
    let arrayOfColors: [UIColor] = [#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 0.5), #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 0.5), #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 0.5), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 0.5), #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 0.5), #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 0.5), #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 0.5), #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 0.5040132705), #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 0.5), #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 0.5), #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 0.5), #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 0.5), #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 0.5), #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 0.5), #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 0.5), #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 0.5), #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 0.5), #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 0.5), #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 0.5), #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 0.5), #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 0.5), #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 0.5), #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 0.5), #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 0.5), #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 0.5), #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 0.5), #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 0.5), #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 0.5), #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 0.5), #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 0.5), #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 0.5), #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 0.5034781678), #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 0.5), #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 0.5), #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 0.5)]
    let arrayOfColors2: [UIColor] = [#colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 0.5036119435), #colorLiteral(red: 0, green: 0.9914394021, blue: 1, alpha: 0.5), #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 0.5), #colorLiteral(red: 1, green: 0.2527923882, blue: 1, alpha: 0.5), #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0.5), #colorLiteral(red: 0.5791940689, green: 0.1280144453, blue: 0.5726861358, alpha: 0.5), #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 0.4917326627), #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 0.5), #colorLiteral(red: 0.4513868093, green: 0.9930960536, blue: 1, alpha: 0.5)]
    
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
        
        //setupView(stackView: createTwoCellsStackView(weekday: "Mon", dayWithMonth: "30 June"))
        
        //TableView
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "TimeLeftTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "timeLeftCell")
        
        let horizontalStackView = createHorisontalStackViewWithDates(calendar: calendar, theLastDate: date)
        setupStackView(stackView: horizontalStackView)
        
  
        
    }
    
    func createTwoCellsStackView(weekday: String, dayWithMonth: String) -> UIStackView {
        
        let lbl1 = UILabel(frame: CGRect(x: 0, y: 0, width: 70, height: 35))
        let lbl2 = UILabel(frame: CGRect(x: 0, y: 35, width: 70, height: 35))
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
            NSLayoutConstraint.activate([sv.widthAnchor.constraint(equalToConstant: 55)])
            return sv
        }()

        
        return stackView
    }
    
    
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
        cell.colorView.backgroundColor = randomColor()
        cell.viewWidth.constant = CGFloat((arrayOfRequiredTimeToComplete[indexPath.row] - 1) * 65 + 60)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func randomColor() -> UIColor {
        let randomIndex = Int(arc4random_uniform(UInt32(arrayOfColors2.count)))
        return arrayOfColors2[randomIndex]
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

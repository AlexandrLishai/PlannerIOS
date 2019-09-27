//
//  DateTimePickerController.swift
//  Planner
//
//  Created by alex on 9/27/19.
//  Copyright © 2019 alex. All rights reserved.
//

import UIKit
import GCCalendar

class DateTimePickerController: UIViewController, GCCalendarViewDelegate {
    
    var datetime:Date!
    var selectedDateTime:Date!
    var delegate:ActionResultDelegate!
    
    var dateFormatter  = DateFormatter()
    
    @IBOutlet weak var calendarView: GCCalendarView!
    
    @IBOutlet weak var labelMonthName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendarView.delegate = self
        calendarView.displayMode = .month
        
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .short
        
        if datetime != nil{
            calendarView.select(date: datetime)
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func calendarView(_ calendarView: GCCalendarView, didSelectDate date: Date, inCalendar calendar: Calendar) {
        dateFormatter.dateFormat = "LLLL yyyy"
        dateFormatter.calendar = calendar
        labelMonthName.text = dateFormatter.string(from: date).capitalized
        selectedDateTime = date
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: actions
    
    @IBAction func clickButtonCancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clickButtonToday(_ sender: UIButton) {
        calendarView.today()
    }
    
    @IBAction func clickButtonSave(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        delegate.done(source: self, data: selectedDateTime)
    }
    
    
    

}

//
//  DateExtension.swift
//  FirstApp
//
//  Created by alex on 8/15/19.
//  Copyright © 2019 alex. All rights reserved.
//

import Foundation

extension Date {
    func rewindDays(days:Int)->Date{
        return Calendar.current.date(byAdding: .day, value: days,  to: self)!
    }
    
    var today: Date {
        return rewindDays(days: 0)
    }
    
    func offsetDays(date: Date) -> Int{
        let cal = Calendar.current
        
        let startOfCurrentDay = cal.startOfDay(for: date)
        let startOfOtherDay = cal.startOfDay(for: self)
        
        return cal.dateComponents([.day], from: startOfCurrentDay, to: startOfOtherDay).day!
    }
}

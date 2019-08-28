//
//  TaskExtension.swift
//  FirstApp
//
//  Created by alex on 8/15/19.
//  Copyright © 2019 alex. All rights reserved.
//

import Foundation

extension Task{
    
    func daysLeft() -> Int!{
        if self.deadline == nil {
            return nil
        }
        
        let deadline = self.deadline! as Date
        
        return deadline.offsetDays(date: Date().today)
    }
}

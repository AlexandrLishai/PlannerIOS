//
//  Task.swift
//  FirstApp
//
//  Created by alex on 8/8/19.
//  Copyright © 2019 alex. All rights reserved.
//

import Foundation

class TaskObject{
    
    init(name:String, category:String) {
        self.name = name
        self.category = category
    }
    
    init(name:String, category:String, deadLine:Date) {
        self.name = name
        self.category = category
        self.deadLine = deadLine
    }
    init(name:String) {
        self.name = name
    }
    
    var name:String = "Task"
    var category:String?
    var deadLine:Date?
    var priority:String?
}

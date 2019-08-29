//
//  TaskDAOImpl.swift
//  FirstApp
//
//  Created by alex on 8/21/19.
//  Copyright © 2019 alex. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class TaskDAOImpl: Crud{
    
    typealias Item = Task
    
    static let current = TaskDAOImpl()
    
    private init(){}
    
    let categoryDAO = CategoryDAOImpl.current
    let priorityDAO = PriorityDAOImpl.current
    
    var items: [Item]!
    
    // MARK: dao
    
    func getAll() -> [Item] {
        let fetchRequest:NSFetchRequest<Item> = Item.fetchRequest()
        
        do {
            items = try context.fetch(fetchRequest)
        }catch {
            fatalError("Error fetching")
        }
        
        return items
    }
    
    func delete(_ item:Item){
        context.delete(item)
        save()
    }
    
    func addOrUpdate(_ item: Item) {
        if !items.contains(item){
            items.append(item)
        }
        save()
    }
    
    func initData(){
        let category1 = addCategory(name: "Sport")
        let category2 = addCategory(name: "Rest")
        let category3 = addCategory(name: "Family")
        
        let priority1 = addPriority(name: "Low", index: 1)
        let priority2 = addPriority(name: "Normal", index: 2)
        let priority3 = addPriority(name: "High", index: 3)
        
        _ = addTask(name: "Go to swimming pool", completed: false, deadline: Date().rewindDays(days: 10), info: "info", category: category1, priority: priority1)
        _ = addTask(name: "Go to park", completed: false, deadline: Date().rewindDays(days: -5), info: "info", category: category2, priority: priority2)
        _ = addTask(name: "Shopping", completed: false, deadline: Date().rewindDays(days: 1), info: "info", category: category3, priority: priority3)
    }
    
    func addCategory(name:String) -> Category{
        
        let category = Category(context: context) // ╤â╨║╨░╨╖╤ï╨▓╨░╨╡╨╝ ╨║╨╛╨╜╤é╨╡╨║╤ü╤é ╨┤╨╗╤Å ╨╛╨▒╤è╨╡╨║╤é╨░
        
        category.name = name
        
        do {
            try context.save() // ╤ü╨╛╤à╤Ç╨░╨╜╤Å╨╡╨╝ ╨║╨░╨╢╨┤╤ï╨╣ ╨╜╨╛╨▓╤ï╨╣ ╨╛╨▒╤è╨╡╨║╤é
        } catch let error as NSError {
            print("Could not save. \(error)")
        }
        
        return category // ╨▓╨╛╨╖╨▓╤Ç╨░╤ë╨░╨╡╨╝ ╤ü╨╛╨╖╨┤╨░╨╜╨╜╤â╤Ä ╨║╨░╤é╨╡╨│╨╛╤Ç╨╕╤Ä
    }
    
    func addPriority(name:String, index: Int32) -> Priority{
        
        let priority = Priority(context: context) // ╤â╨║╨░╨╖╤ï╨▓╨░╨╡╨╝ ╨║╨╛╨╜╤é╨╡╨║╤ü╤é ╨┤╨╗╤Å ╨╛╨▒╤è╨╡╨║╤é╨░
        
        priority.name = name
        priority.index = index
        
        do {
            try context.save() // ╤ü╨╛╤à╤Ç╨░╨╜╤Å╨╡╨╝ ╨║╨░╨╢╨┤╤ï╨╣ ╨╜╨╛╨▓╤ï╨╣ ╨╛╨▒╤è╨╡╨║╤é
        } catch let error as NSError {
            print("Could not save. \(error)")
        }
        
        return priority // ╨▓╨╛╨╖╨▓╤Ç╨░╤ë╨░╨╡╨╝ ╤ü╨╛╨╖╨┤╨░╨╜╨╜╤ï╨╣ ╨┐╤Ç╨╕╨╛╤Ç╨╕╤é╨╡╤é
    }
    
    
    func addTask(name:String, completed:Bool, deadline:Date?, info:String?, category:Category?, priority:Priority?) -> Task{ // ╨╛╨┐╤å╨╕╨╛╨╜╨░╨╗╤î╨╜╤ï╨╡ ╤é╨╕╨┐╤ï ╨╜╨╡╨╛╨▒╤Å╨╖╨░╤é╨╡╨╗╤î╨╜╨╛ ╨┐╨╡╤Ç╨╡╨┤╨░╨▓╨░╤é╤î
        
        let task = Task(context: context) // ╤â╨║╨░╨╖╤ï╨▓╨░╨╡╨╝ ╨║╨╛╨╜╤é╨╡╨║╤ü╤é ╨┤╨╗╤Å ╨╛╨▒╤è╨╡╨║╤é╨░
        
        task.name = name
        task.completed = completed
        task.deadline = deadline as! NSDate
        task.info = info
        task.category = category
        task.priority = priority
        
        do {
            try context.save() // ╤ü╨╛╤à╤Ç╨░╨╜╤Å╨╡╨╝ ╨║╨░╨╢╨┤╤ï╨╣ ╨╜╨╛╨▓╤ï╨╣ ╨╛╨▒╤è╨╡╨║╤é
        } catch let error as NSError {
            print("Could not save. \(error)")
        }
        
        return task // ╨▓╨╛╨╖╨▓╤Ç╨░╤ë╨░╨╡╨╝ ╤ü╨╛╨╖╨┤╨░╨╜╨╜╤â╤Ä ╨╖╨░╨┤╨░╤ç╤â
    }
    
}


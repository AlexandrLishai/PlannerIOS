//
//  CategoryDAOImpl.swift
//  FirstApp
//
//  Created by alex on 8/21/19.
//  Copyright © 2019 alex. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CategoryDAOImpl: Crud{
    
    typealias Item = Category
    
    static let current = CategoryDAOImpl()
    
    private init(){}
    
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
    
    func getName(_ item: Category) -> String {
        return item.name!
    }
    
}

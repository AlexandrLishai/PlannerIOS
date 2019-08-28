//
//  Crud.swift
//  FirstApp
//
//  Created by alex on 8/22/19.
//  Copyright © 2019 alex. All rights reserved.
//

import Foundation
import CoreData

protocol Crud {
    
    associatedtype Item: NSManagedObject
    
    var items:[Item]! {get set}
    
    func addOrUpdate(_ item:Item)
    
    func getAll() -> [Item]
    
    func delete(_ item:Item)
    
}

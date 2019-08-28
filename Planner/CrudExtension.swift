//
//  CrudExtension.swift
//  FirstApp
//
//  Created by alex on 8/22/19.
//  Copyright © 2019 alex. All rights reserved.
//

import Foundation
import CoreData
import UIKit

extension Crud{
    
    var context:NSManagedObjectContext{
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    func save(){
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
    
}

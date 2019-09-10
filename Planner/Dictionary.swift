//
//  Dictionary.swift
//  Planner
//
//  Created by alex on 9/9/19.
//  Copyright © 2019 alex. All rights reserved.
//

import Foundation
import UIKit

class Dictionary<T:Crud> {
    
    var currentItem:T.Item!
    var currentCheckedIndexPath:IndexPath!
    var currentDAO:T!
    
    var dictionaryList:[T.Item]!
    
    var delegate:ActionResultDelegate!
    
    var tableViewDictionary: UITableView!
    
}

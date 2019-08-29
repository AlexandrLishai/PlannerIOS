//
//  ActionResultDelegate.swift
//  Planner
//
//  Created by alex on 8/29/19.
//  Copyright © 2019 alex. All rights reserved.
//

import Foundation
import UIKit

protocol ActionResultDelegate{
    func done(source: UIViewController, data: Any?)
    
    func cancel(source: UIViewController, data: Any?)
}

extension ActionResultDelegate{
    func done(source: UIViewController, data: Any?){
        fatalError("not emplemented")
    }
    
    func cancel(source: UIViewController, data: Any?){
        fatalError("not emplemented")
    }
}

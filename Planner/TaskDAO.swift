//
//  TaskDAO.swift
//  Planner
//
//  Created by alex on 9/26/19.
//  Copyright © 2019 alex. All rights reserved.
//

import Foundation

protocol TaskDAO: Crud{
    
    func search(_ text:String)->[Item]
    
}

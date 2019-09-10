//
//  AreaTabButton.swift
//  Planner
//
//  Created by alex on 9/10/19.
//  Copyright © 2019 alex. All rights reserved.
//

import UIKit

class AreaTabButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func point(inside point:CGPoint, with _:UIEvent?) -> Bool{
        let margin: CGFloat = 10
        let area = self.bounds.insetBy(dx: -margin, dy: -margin)
        return area.contains(point)
    }

}

//
//  TaskInfoViewCell.swift
//  Planner
//
//  Created by alex on 8/29/19.
//  Copyright © 2019 alex. All rights reserved.
//

import UIKit

class TaskInfoViewCell: UITableViewCell {

    @IBOutlet weak var textTaskInfo: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

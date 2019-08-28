//
//  TaskListViewCell.swift
//  FirstApp
//
//  Created by alex on 8/9/19.
//  Copyright © 2019 alex. All rights reserved.
//

import UIKit

class TaskListViewCell: UITableViewCell {
    
    @IBOutlet weak var labelTaskName: UILabel!
    @IBOutlet weak var labelTaskCategory: UILabel!
    @IBOutlet weak var labelTaskDeadline: UILabel!    
    @IBOutlet weak var labelTaskPriority: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

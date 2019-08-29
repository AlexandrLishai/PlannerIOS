//
//  TaskNameViewCell.swift
//  Planner
//
//  Created by alex on 8/29/19.
//  Copyright © 2019 alex. All rights reserved.
//

import UIKit

class TaskNameViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var textTaskName: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        textTaskName.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textTaskName.resignFirstResponder()
        return true
    }
}

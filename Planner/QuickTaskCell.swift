//
//  QuickTaskCell.swift
//  Planner
//
//  Created by alex on 9/26/19.
//  Copyright © 2019 alex. All rights reserved.
//

import UIKit

class QuickTaskCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var textQuickTask: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        textQuickTask.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textQuickTask.resignFirstResponder()
        return true
    }

    
}

//
//  DictionaryListViewCell.swift
//  Planner
//
//  Created by alex on 9/5/19.
//  Copyright © 2019 alex. All rights reserved.
//

import UIKit

class DictionaryListViewCell: UITableViewCell {

    @IBOutlet weak var labelDictionaryName: UILabel!
    
    @IBOutlet weak var buttonCheck: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

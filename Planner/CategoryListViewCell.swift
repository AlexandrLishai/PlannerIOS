//
//  CategoryListViewCell.swift
//  Planner
//
//  Created by alex on 8/30/19.
//  Copyright © 2019 alex. All rights reserved.
//

import UIKit

class CategoryListViewCell: UITableViewCell {

    @IBOutlet weak var labelCategoryName: UILabel!
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

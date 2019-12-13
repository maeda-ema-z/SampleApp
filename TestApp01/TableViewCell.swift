//
//  TableViewCell.swift
//  TestApp01
//
//  Created by admin on 12/12/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindData(text: String) {
        label.text = text
    }
}

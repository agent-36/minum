//
//  HistoryDetailTableViewCell.swift
//  minum
//
//  Created by Ihwan ID on 02/06/20.
//  Copyright © 2020 Ihwan ID. All rights reserved.
//

import UIKit

class HistoryDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var hour: UILabel!
    @IBOutlet weak var desc: UILabel!
    
    @IBOutlet weak var photo: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        hour.text = "19:00"
        desc.text = "You Drink 250ml water"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

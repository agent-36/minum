//
//  HistoryTableViewCell.swift
//  minum
//
//  Created by Ihwan ID on 02/06/20.
//  Copyright © 2020 Ihwan ID. All rights reserved.
//

import UIKit
import WaveAnimationView

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var waterIcon: UIView!
    @IBOutlet weak var date: UILabel!
    
     var wave: WaveAnimationView!
    override func awakeFromNib() {
        super.awakeFromNib()
        waterIcon.layer.cornerRadius = waterIcon.frame.size.width/2
               waterIcon.clipsToBounds = true

               waterIcon.layer.borderColor = UIColor(rgb: 0x4D80E4).cgColor
               waterIcon.layer.backgroundColor = UIColor(rgb: 0x253961).cgColor
               waterIcon.layer.borderWidth = 5.0
           
           
               wave = WaveAnimationView(frame: CGRect(origin: .zero, size: waterIcon.bounds.size), color: UIColor(rgb: 0x5CC2F4))
                      waterIcon.addSubview(wave)
                      wave.startAnimation()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

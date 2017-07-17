//
//  ResultCell.swift
//  Calculator
//
//  Created by Szamódy Zs. Balázs on 2017. 07. 14..
//  Copyright © 2017. Szamódy Zs. Balázs. All rights reserved.
//

import UIKit

class ResultCell: UITableViewCell {
    @IBOutlet weak var calculationLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

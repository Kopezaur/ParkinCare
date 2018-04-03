//
//  EvaluationTableViewCell.swift
//  ParkinCare
//
//  Created by julia on 03/04/2018.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import UIKit

class SyntheseTableViewCell: UITableViewCell {

    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var etatLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

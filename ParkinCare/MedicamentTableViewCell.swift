//
//  MedicamentTableViewCell.swift
//  ParkinCare
//
//  Created by Fabien TURGUT on 13/03/2018.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import UIKit

class MedicamentTableViewCell: UITableViewCell {
    @IBOutlet weak var medicamentNameLabel: UILabel!
    @IBOutlet weak var quantiteMedicament: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

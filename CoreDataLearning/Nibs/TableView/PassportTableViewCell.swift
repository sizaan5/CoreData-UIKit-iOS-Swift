//
//  PassportTableViewCell.swift
//  CoreDataLearning
//
//  Created by Izaan Saleem on 14/05/2024.
//

import UIKit

class PassportTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblPassportId: UILabel!
    @IBOutlet weak var empName: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

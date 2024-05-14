//
//  VehiclesTableViewCell.swift
//  CoreDataLearning
//
//  Created by Izaan Saleem on 14/05/2024.
//

import UIKit

class VehiclesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblCarName: UILabel!
    @IBOutlet weak var lblType: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//
//  EmployeeTableViewCell.swift
//  CoreDataLearning
//
//  Created by Izaan Saleem on 13/05/2024.
//

import UIKit

class EmployeeTableViewCell: UITableViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var imgProfilePic: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

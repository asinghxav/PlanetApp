//
//  PlanetListTableViewCell.swift
//  PlanetApp
//
//  Created by Abhishek Singh on 08/01/19.
//  Copyright © 2019 Abhishek Singh. All rights reserved.
//

import UIKit

class PlanetListTableViewCell: UITableViewCell {

    @IBOutlet weak var planetName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(withViewModel viewModel: PlanetModelPresentable) -> (Void) {
        
        if let name = viewModel.name {
            planetName.text = name
        }
    }
}

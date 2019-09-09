//
//  ImageCell.swift
//  Milestone4
//
//  Created by RAJ RAVAL on 09/09/19.
//  Copyright © 2019 Buck. All rights reserved.
//

import UIKit

class ImageCell: UITableViewCell {
    
    @IBOutlet var captionImage: UIImageView!
    @IBOutlet var captionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  RightMenuCustomCell.swift
//  CineBul
//
//  Created by Baran on 26.05.2017.
//  Copyright © 2017 CaWeb. All rights reserved.
//

import UIKit

class RightMenuCustomCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    @IBOutlet weak var customImageView: UIImageView!
    @IBOutlet weak var customLabel: UILabel!
    
    
}


//
//  AdvertCell.swift
//  App To Rich
//
//  Created by bilal on 28/09/17.
//  Copyright © 2017 bilal. All rights reserved.
//

import UIKit

class AdvertCell: UITableViewCell {

    @IBOutlet weak var imgViewAdvert: UIImageView!
    
    @IBOutlet weak var lblAdvertValue: UILabel!
    
    @IBOutlet weak var lblAdvertName: UILabel!
    
    @IBOutlet weak var lblAdvertURL: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with item: AdvertModel) {
        self.lblAdvertName.text = item.name
        self.lblAdvertValue.text = item.value
        self.lblAdvertURL.text = item.uRL
    }

}

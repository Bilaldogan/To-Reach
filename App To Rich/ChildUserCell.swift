//
//  ChildUserCell.swift
//  App To Rich
//
//  Created by bilal on 27/09/17.
//  Copyright © 2017 bilal. All rights reserved.
//

import UIKit

class ChildUserCell: UITableViewCell {

    @IBOutlet weak var lblChildUserCount: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblUserNickName: UILabel!
    @IBOutlet weak var imgViewChild: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.imgViewChild.layoutIfNeeded()
        self.imgViewChild.layer.cornerRadius = self.imgViewChild.bounds.width / 2.0
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
    func configure(with item: SubProfileModel) {
        self.lblChildUserCount.text = item.count
        self.lblUserName.text = item.userName
        
        
    }

}

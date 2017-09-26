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
        self.imgViewChild.layer.cornerRadius = self.imgViewChild.frame.size.width / 2
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

           }

}

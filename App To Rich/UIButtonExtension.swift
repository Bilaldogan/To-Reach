//
//  UIButtonExtension.swift
//  App To Rich
//
//  Created by Baran on 12.10.2017.
//  Copyright © 2017 bilal. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    func buttonImageRendering(imageNamed : String , imageColor : UIColor){
        let logoImage = UIImage(named: imageNamed)
        let tintedImage = logoImage?.withRenderingMode(.alwaysTemplate)
        self.setImage(tintedImage, for: .normal)
        self.imageView?.contentMode = .scaleAspectFit
        self.tintColor = imageColor
    }
    
}

//
//  ColorChangeImageView.swift
//  CineBul
//
//  Created by Baran on 30.05.2017.
//  Copyright © 2017 CaWeb. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class ColorChangeImageView: UIImageView {
    
    
    var isInterfaceBuilder: Bool = false
    
    
    @IBInspectable var ImageColor:UIColor = .black {
        didSet {
            overrideImageColor(choiceColor: ImageColor)
        }
    }
    @IBInspectable var circularButton: Bool = true{
        didSet {
            
            self.isInterfaceBuilder = true
            layer.cornerRadius = self.frame.height / 2
            layer.masksToBounds = self.frame.height / 2 > 0
        }
    }
    
    func overrideImageColor(choiceColor:UIColor){
        
        let kullaniciImage = self.image
        let kullanicitintedImage = kullaniciImage?.withRenderingMode(.alwaysTemplate)
        self.image = kullanicitintedImage
        self.tintColor = choiceColor
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if isInterfaceBuilder {
            layer.cornerRadius = self.frame.height / 2
            layer.masksToBounds = self.frame.height / 2 > 0
        }
        else{
            
        }
        
    }

    
    
}

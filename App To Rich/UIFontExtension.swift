//
//  UIFontExtensiob.swift
//  CineBul
//
//  Created by Baran on 26.05.2017.
//  Copyright © 2017 CaWeb. All rights reserved.
//

import Foundation
import UIKit

extension AnimatedTextInput{
    
    func addResponsiveFont(fontSize : Double){
        let currentFontName = self.font?.fontName
        var calculatedFont: UIFont?
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height

        switch height {
        case 480.0: //Iphone 3,4,SE => 3.5 inch
            calculatedFont = UIFont(name: currentFontName!, size: CGFloat(fontSize - 3))
            self.style.textInputFont = calculatedFont!
            break
        case 568.0: //iphone 5, 5s => 4 inch
            calculatedFont = UIFont(name: currentFontName!, size: CGFloat(fontSize - 2))
            self.style.textInputFont = calculatedFont!
            break
        case 667.0: //iphone 6, 6s => 4.7 inch
            calculatedFont = UIFont(name: currentFontName!, size: CGFloat(fontSize - 1))
            self.style.textInputFont = calculatedFont!
            break
        case 736.0: //iphone 6s+ 6+ => 5.5 inch
            calculatedFont = UIFont(name: currentFontName!, size: CGFloat(fontSize))
            self.style.textInputFont = calculatedFont!
            break
        case 1024.0:
            calculatedFont = UIFont(name: currentFontName!, size: CGFloat(fontSize + 9))
            self.style.textInputFont = calculatedFont!
            break
        case 1366.0:
            calculatedFont = UIFont(name: currentFontName!, size: CGFloat(fontSize + 10))
            self.style.textInputFont = calculatedFont!
            break
        default:
            print("not an iPhone")
            break
        }
        
    }
    
    
}

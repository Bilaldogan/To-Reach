//
//  CustomTextField.swift
//  App To Rich
//
//  Created by bilal on 12/10/17.
//  Copyright © 2017 bilal. All rights reserved.
//

import UIKit

@IBDesignable
class CustomTextField: UITextField {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var TextFieldFontSize: CGFloat = 0 {
        didSet {
            overrideFontSize(fontSize: TextFieldFontSize)
        }
    }
    @IBInspectable var isBold: Bool = false {
        didSet {
            overrideFontSize(fontSize: TextFieldFontSize)
        }
    }
    
    func overrideFontSize(fontSize:CGFloat){
        var calculatedFont: UIFont?
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height
        switch height {
        case 480.0: //Iphone 3,4,SE => 3.5 inch
            calculatedFont = UIFont.systemFont(ofSize: fontSize * 0.6)
            self.font = calculatedFont
            break
        case 568.0: //iphone 5, 5s => 4 inch
            calculatedFont = UIFont.systemFont(ofSize: fontSize * 0.7)
            self.font = calculatedFont
            break
        case 667.0: //iphone 6, 6s => 4.7 inch
            calculatedFont =  UIFont.systemFont(ofSize: fontSize * 0.8)
            self.font = calculatedFont
            break
        case 667.0: //iphone 7 =>
            calculatedFont =  UIFont.systemFont(ofSize: fontSize*0.9)
            self.font = calculatedFont
            break
        case 736.0: //iphone 7+plus => 5.5 inch
            calculatedFont =  UIFont.systemFont(ofSize: fontSize*1.0)
            self.font = calculatedFont
            break
        case 1024.0: //ipad for 9.7 inch
            calculatedFont =  UIFont.systemFont(ofSize: fontSize*2.0)
            self.font = calculatedFont
            break
        case 1112.0: //ipad for 10.5 inch
            calculatedFont =  UIFont.systemFont(ofSize: fontSize*2.5)
            self.font = calculatedFont
            break
        case 1366.0: //ipad for 12.9 inch
            calculatedFont =  UIFont.systemFont(ofSize: fontSize*3.0)
            self.font = calculatedFont
            break
        default:
            print("this is not an iPhone")
            break
        }
    }
    
    //TextField padding verildi.
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5);
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    
}

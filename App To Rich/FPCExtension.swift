//
//  FPCExtension.swift
//  App To Rich
//
//  Created by Baran on 27.09.2017.
//  Copyright © 2017 bilal. All rights reserved.
//

import Foundation
import UIKit

// For Support Functions
extension ForgotPasswordController {
    
    //For haydi başlayalım function
    internal func textFieldRegexHelp() {
        let isNetAvaible = self.hasConnectivity()
        if isNetAvaible{
            if  mailTextField.text! == ""  {
                self.dismissKeyboard()
                //Popup çağır
            }
            else if RegexClass.isValidEmail(testStr: self.mailTextField.text!) == false {
                self.dismissKeyboard()
                //Popup çağır
            }
            else{
                //dopru yol
            }
        }
        else{
            self.view.makeToast("Lütfen internet bağlantınızı kontrol ediniz.")
            self.dismissKeyboard()
        }
    }
    
    
    //TextField Animated Function'ss
    internal func renderigKullanici() {
        emailImageView.imageViewRendering(imageNamed: "at", imageColor: UIColor.gray.withAlphaComponent(0.7))
        
    }
    internal func renderigEmail() {
        emailImageView.imageViewRendering(imageNamed: "at", imageColor: ColorUtil.pinkColor)
        
    }
    internal func renderigGsm() {
        emailImageView.imageViewRendering(imageNamed: "at", imageColor: UIColor.gray.withAlphaComponent(0.7))
        
    }
    internal func renderigAgainPassword() {
        emailImageView.imageViewRendering(imageNamed: "at", imageColor: UIColor.gray.withAlphaComponent(0.7))
        
        
    }
    internal func fullBlackImage(){
        
        emailImageView.imageViewRendering(imageNamed: "at", imageColor: UIColor.gray.withAlphaComponent(0.7))
        
        
    }
    
    internal func textFieldsProperties(){
        
        
        mailTextField.backgroundColor = UIColor.clear
        mailTextField.accessibilityLabel = "standard_text_input"
        mailTextField.placeHolderText = "E-posta adresiniz"
        mailTextField.textColor = UIColor.white
        mailTextField.type = .email
        mailTextField.style = CustomTextInputStyle()
        
        
    }
    internal func textFieldsFrontEnd(){
        
        mailTextField.style.marginPosition = self.emailImageView.frame.width
        mailTextField.contentInset = UIEdgeInsetsMake(22.5, 0, 0, 0)
        
       
        mailTextField.addResponsiveFont(fontSize: 13)
        
        mailTextField.style.placeholderSelfPosition = 22.5 + (self.emailImageView.frame.height / 4)
        
      
    }
    
    ///Keyboard Action Function'ss
    internal func keyboardEvents(){
        NotificationCenter.default.addObserver(self, selector: #selector(LoginController.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginController.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(LoginController.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        
    }
    internal func keyboardWillShow(notification: NSNotification) {
        if let _ = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= ( self.view.frame.height * 0.25 )
            }
        }
    }
    
    //******
    internal func keyboardWillHide(notification: NSNotification) {
        if let _ = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == -self.view.frame.height * 0.25  {
                self.view.frame.origin.y += ( self.view.frame.height * 0.25 )
            }
            
        }
    }
    
    internal func dismissKeyboard() {
        view.endEditing(true)
        self.fullBlackImage()
    }
    
}

//
//  RCExtension.swift
//  App To Rich
//
//  Created by Baran on 27.09.2017.
//  Copyright © 2017 bilal. All rights reserved.
//

import Foundation
import UIKit

// For Support Functions
extension RegisterController {
    
    //For haydi başlayalım function
    internal func textFieldRegexHelp() {
        let isNetAvaible = self.hasConnectivity()
        if isNetAvaible{
            if nameTextField.text! == "" || mailTextField.text! == "" || passTextField.text! == "" || againPasswordTextField.text! == ""{
                self.dismissKeyboard()
                //Popup çağır
            }
            else if RegexClass.validateButunNumaralarSifirOlarmaz(textField: passTextField) == false{
                self.dismissKeyboard()
                //Popup çağır
            }
            else if RegexClass.isValidEmail(testStr: self.mailTextField.text!) == false {
                self.dismissKeyboard()
                //Popup çağır
            }
            else if  passTextField.text! !=  againPasswordTextField.text!{
                self.dismissKeyboard()
                //Popup çağır
            }
            else{
                self.dismissKeyboard()
                registerService.serviceDelegate = self
                var sendModel : RegisterServiceSendData = RegisterServiceSendData()
                sendModel.UserEmail = mailTextField.text!
                sendModel.UserName = nameTextField.text!
                sendModel.UserPass = passTextField.text!
                sendModel.MacId = UIDevice.current.identifierForVendor!.uuidString
                sendModel.OneSignalId = "dsçkfjslkfjlskdfjsdlkfj"
                sendModel.RefNo = self.referenceCode
                registerService.password = self.passTextField.text!
                self.showProgressView()
                if hasConnectivity() {
                registerService.dispatchGetService(model: sendModel)
                } else {
                    // Message Göster
                }
            }
        }
        else{
            self.dismissKeyboard()
        }
    }
    
    
    //TextField Animated Function'ss
    internal func renderigKullanici() {
        isimIconUIimageView.imageViewRendering(imageNamed: "kullanici", imageColor: ColorUtil.pinkColor)
        emailImageView.imageViewRendering(imageNamed: "at", imageColor: UIColor.gray.withAlphaComponent(0.7))
        gsmImageView.imageViewRendering(imageNamed: "kilit", imageColor: UIColor.gray.withAlphaComponent(0.7))
        againPassImageView.imageViewRendering(imageNamed: "kilit", imageColor: UIColor.gray.withAlphaComponent(0.7))
    }
    internal func renderigEmail() {
        isimIconUIimageView.imageViewRendering(imageNamed: "kullanici", imageColor: UIColor.gray.withAlphaComponent(0.7))
        emailImageView.imageViewRendering(imageNamed: "at", imageColor: ColorUtil.pinkColor)
        gsmImageView.imageViewRendering(imageNamed: "kilit", imageColor: UIColor.gray.withAlphaComponent(0.7))
        againPassImageView.imageViewRendering(imageNamed: "kilit", imageColor: UIColor.gray.withAlphaComponent(0.7))
    }
    internal func renderigGsm() {
        isimIconUIimageView.imageViewRendering(imageNamed: "kullanici", imageColor: UIColor.gray.withAlphaComponent(0.7))
        emailImageView.imageViewRendering(imageNamed: "at", imageColor: UIColor.gray.withAlphaComponent(0.7))
        gsmImageView.imageViewRendering(imageNamed: "kilit", imageColor: ColorUtil.pinkColor)
        againPassImageView.imageViewRendering(imageNamed: "kilit", imageColor: UIColor.gray.withAlphaComponent(0.7))
    }
    internal func renderigAgainPassword() {
        isimIconUIimageView.imageViewRendering(imageNamed: "kullanici", imageColor: UIColor.gray.withAlphaComponent(0.7))
        emailImageView.imageViewRendering(imageNamed: "at", imageColor: UIColor.gray.withAlphaComponent(0.7))
        gsmImageView.imageViewRendering(imageNamed: "kilit", imageColor: UIColor.gray.withAlphaComponent(0.7))
        againPassImageView.imageViewRendering(imageNamed: "kilit", imageColor: ColorUtil.pinkColor)
        
    }
    internal func fullBlackImage(){
        isimIconUIimageView.imageViewRendering(imageNamed: "kullanici", imageColor: UIColor.gray.withAlphaComponent(0.7))
        emailImageView.imageViewRendering(imageNamed: "at", imageColor: UIColor.gray.withAlphaComponent(0.7))
        gsmImageView.imageViewRendering(imageNamed: "kilit", imageColor: UIColor.gray.withAlphaComponent(0.7))
        againPassImageView.imageViewRendering(imageNamed: "kilit", imageColor: UIColor.gray.withAlphaComponent(0.7))
    }
    
    internal func textFieldsProperties(){
        nameTextField.backgroundColor = UIColor.clear
        nameTextField.accessibilityLabel = "standard_text_input"
        nameTextField.placeHolderText = "İsim"
        nameTextField.textColor = UIColor.white
        nameTextField.type = .standard
        nameTextField.style = CustomTextInputStyle()
        
        
        mailTextField.backgroundColor = UIColor.clear
        mailTextField.accessibilityLabel = "standard_text_input"
        mailTextField.placeHolderText = "E-posta adresiniz"
        mailTextField.textColor = UIColor.white
        mailTextField.type = .email
        mailTextField.style = CustomTextInputStyle()
        
        
        passTextField.backgroundColor = UIColor.clear
        passTextField.placeHolderText = "Şifreniz"
        passTextField.textColor = UIColor.white
        passTextField.type = .password(toggleable: false)
        passTextField.style = CustomTextInputStyle()
        
        
        againPasswordTextField.backgroundColor = UIColor.clear
        againPasswordTextField.placeHolderText = "Tekrar şifriniz"
        againPasswordTextField.textColor = UIColor.white
        againPasswordTextField.type = .password(toggleable: false)
        againPasswordTextField.style = CustomTextInputStyle()
        
        
    }
    internal func textFieldsFrontEnd(){
        
        nameTextField.style.marginPosition = self.isimIconUIimageView.frame.width
        nameTextField.contentInset = UIEdgeInsetsMake(22.5, 0, 0, 0)
        
        mailTextField.style.marginPosition = self.emailImageView.frame.width
        mailTextField.contentInset = UIEdgeInsetsMake(22.5, 0, 0, 0)
        
        passTextField.style.marginPosition = self.gsmImageView.frame.width
        passTextField.contentInset = UIEdgeInsetsMake(22.5, 0, 0, 0)
        
        againPasswordTextField.style.marginPosition = self.againPassImageView.frame.width
        againPasswordTextField.contentInset = UIEdgeInsetsMake(22.5, 0, 0, 0)
        
        nameTextField.addResponsiveFont(fontSize: 13)
        nameTextField.style.placeholderSelfPosition = 22.5 + (self.isimIconUIimageView.frame.height / 4)
        passTextField.addResponsiveFont(fontSize: 13)
        passTextField.style.placeholderSelfPosition = 22.5 + (self.againPassImageView.frame.height / 4)
        mailTextField.addResponsiveFont(fontSize: 13)
        mailTextField.style.placeholderSelfPosition = 22.5 + (self.againPassImageView.frame.height / 4)
        againPasswordTextField.addResponsiveFont(fontSize: 13)
        againPasswordTextField.style.placeholderSelfPosition = 22.5 + (self.againPassImageView.frame.height / 4)
        
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

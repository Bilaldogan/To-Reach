//
//  LCExtension.swift
//  App To Rich
//
//  Created by Baran on 27.09.2017.
//  Copyright © 2017 bilal. All rights reserved.
//

import Foundation
import UIKit

// For Support Functions
extension LoginController {
    
    //For haydi başlayalım function
    internal func textFieldRegexHelp() {
        let isNetAvaible = self.hasConnectivity()
        if isNetAvaible{
            if  mailTextField.text! == "" || passTextField.text! == "" {
                self.dismissKeyboard()
                self.view.makeToast("Lütfen tüm boş alanları doldurunuz.")
                //Popup çağır
            }
            else if RegexClass.validateButunNumaralarSifirOlarmaz(textField: passTextField) == false{
                self.dismissKeyboard()
                self.view.makeToast("Tüm numaralar 0 olamaz.")
                //Popup çağır
            }
            else if RegexClass.isValidEmail(testStr: self.mailTextField.text!) == false {
                self.dismissKeyboard()
                self.view.makeToast("Lütfen doğru bir email adresi giriniz.")
                //Popup çağır
            }
            else{
                self.dismissKeyboard()
                loginService.serviceDelegate = self
                let mail = mailTextField.text!
                let password = passTextField.text!
                self.showProgressView()
                if hasConnectivity() {
                loginService.dispatchGetService(mail: mail, password: password)
                } else {
                    self.view.makeToast("Lütfen internet bağlantınızı kontrol ediniz.")
                    //message Göster
                }
            }
        }
        else{
            self.view.makeToast("Lütfen internet bağlantınızı kontrol ediniz.")
            self.dismissKeyboard()
        }
    }
    
    func configure(){
        self.backArrowButton.buttonImageRendering(imageNamed: "ok-sol", imageColor: UIColor.white)
    }
    
    //TextField Animated Function'ss
    internal func renderigKullanici() {
        emailImageView.imageViewRendering(imageNamed: "at", imageColor: UIColor.gray.withAlphaComponent(0.7))
        gsmImageView.imageViewRendering(imageNamed: "kilit", imageColor: UIColor.gray.withAlphaComponent(0.7))
    }
    internal func renderigEmail() {
        emailImageView.imageViewRendering(imageNamed: "at", imageColor: ColorUtil.pinkColor)
        gsmImageView.imageViewRendering(imageNamed: "kilit", imageColor: UIColor.gray.withAlphaComponent(0.7))
    }
    internal func renderigGsm() {
        emailImageView.imageViewRendering(imageNamed: "at", imageColor: UIColor.gray.withAlphaComponent(0.7))
        gsmImageView.imageViewRendering(imageNamed: "kilit", imageColor: ColorUtil.pinkColor)
    }
    internal func renderigAgainPassword() {
        emailImageView.imageViewRendering(imageNamed: "at", imageColor: UIColor.gray.withAlphaComponent(0.7))
        gsmImageView.imageViewRendering(imageNamed: "kilit", imageColor: UIColor.gray.withAlphaComponent(0.7))
        
    }
    internal func fullBlackImage(){
    
        emailImageView.imageViewRendering(imageNamed: "at", imageColor: UIColor.gray.withAlphaComponent(0.7))
        gsmImageView.imageViewRendering(imageNamed: "kilit", imageColor: UIColor.gray.withAlphaComponent(0.7))
      
    }
    
    internal func textFieldsProperties(){
        
        
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
        
        
       
        
        
    }
    internal func textFieldsFrontEnd(){
        
        mailTextField.style.marginPosition = self.emailImageView.frame.width
        mailTextField.contentInset = UIEdgeInsetsMake(22.5, 0, 0, 0)
        
        passTextField.style.marginPosition = self.gsmImageView.frame.width
        passTextField.contentInset = UIEdgeInsetsMake(22.5, 0, 0, 0)
        
        passTextField.addResponsiveFont(fontSize: 15)
        mailTextField.addResponsiveFont(fontSize: 15)
        
        mailTextField.style.placeholderSelfPosition = 22.5 + (self.emailImageView.frame.height / 4)
        
        passTextField.style.placeholderSelfPosition = 22.5 + (self.emailImageView.frame.height / 4)
    }
    
     
    
}

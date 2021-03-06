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
                self.view.makeToast("Lütfen tüm boş alanları doldurunuz.")
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
            else if  passTextField.text! !=  againPasswordTextField.text!{
                self.dismissKeyboard()
                self.view.makeToast("Lütfen şifrelerinizin aynı olduğundan emin olun")
                //Popup çağır
            }
            else if GlobalData.kullaniciSozlesmesiKey == "0"{
                self.dismissKeyboard()
                self.view.makeToast("Kullanıcı sözleşmesini kabul etmeniz gerekmektedir")
            }
            else{
                self.dismissKeyboard()
                registerService.serviceDelegate = self
                var sendModel : RegisterServiceSendData = RegisterServiceSendData()
                sendModel.UserEmail = mailTextField.text!
                sendModel.UserName = nameTextField.text!
                sendModel.UserPass = passTextField.text!
                sendModel.MacId = UIDevice.current.identifierForVendor!.uuidString
                if UserPrefence.getOneSignalId() != "" {
                    sendModel.OneSignalId = UserPrefence.getOneSignalId()
                }
                else{
                    sendModel.OneSignalId = "040404"
                }
                
                print(self.referenceCode)
                sendModel.RefNo = self.referenceCode

                self.showProgressView()
                if hasConnectivity() {
                registerService.dispatchGetService(model: sendModel)
                } else {
                    self.view.makeToast("Lütfen internet bağlantınızı kontrol ediniz.")
                    // Message Göster
                }
            }
        }
        else{
            self.dismissKeyboard()
            self.view.makeToast("Lütfen internet bağlantınızı kontrol ediniz.")
        }
    }
    
    func configure(){
        self.backArrowButton.buttonImageRendering(imageNamed: "ok-sol", imageColor: UIColor.white)
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
        
        nameTextField.addResponsiveFont(fontSize: 15)
        nameTextField.style.placeholderSelfPosition = 22.5 + (self.isimIconUIimageView.frame.height / 4)
        passTextField.addResponsiveFont(fontSize: 15)
        passTextField.style.placeholderSelfPosition = 22.5 + (self.againPassImageView.frame.height / 4)
        mailTextField.addResponsiveFont(fontSize: 15)
        mailTextField.style.placeholderSelfPosition = 22.5 + (self.againPassImageView.frame.height / 4)
        againPasswordTextField.addResponsiveFont(fontSize: 15)
        againPasswordTextField.style.placeholderSelfPosition = 22.5 + (self.againPassImageView.frame.height / 4)
        
    }
    
    internal func bufferFunc() {
        if GlobalData.bufferEmail != "" {
            self.mailTextField.text = GlobalData.bufferEmail
        }
        if GlobalData.bufferName != "" {
            self.nameTextField.text = GlobalData.bufferName
        }
        if GlobalData.bufferPass != ""{
            self.passTextField.text = GlobalData.bufferPass
        }
        if GlobalData.bufferPass != ""{
            self.againPasswordTextField.text = GlobalData.bufferAgainPass
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? KullaniciSozlesmesiController {
            destinationVC.referenceCode = self.referenceCode
        }
    }
    
}

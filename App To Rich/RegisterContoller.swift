//
//  RegisterController.swift
//  AppToRich
//
//  Created by Baran on 1.05.2017.
//  Copyright © 2017 CaWeb. All rights reserved.
//

import UIKit

class RegisterController: BaseController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTappedTo()
        self.fullBlackImage()
        self.renderigSozlesmesi()
        self.textFieldsProperties()
        self.bufferFunc()
        self.configure()
        print(referenceCode)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        kayıtOlButton.layoutIfNeeded()
        objectFrame = self.view.convert(kayıtOlButton.frame, from: kayıtOlButton.superview)
        isScreenWillMove = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true // for navigation bar hide
      
    }
    override func viewWillLayoutSubviews() {
        self.textFieldsFrontEnd()
    }
    
    
    private func addTappedTo(){
        debugPrint("addTappedTo")
        
        nameTextField.tapAction = { [weak self] in
            guard let strongself = self else { return }
            strongself.renderigKullanici()
        }
        
        mailTextField.tapAction = { [weak self] in
            guard let strongself = self else { return }
            strongself.renderigEmail()
        }
        
        passTextField.tapAction = { [weak self] in
            guard let strongself = self else { return }
            strongself.renderigGsm()
        }
        
        againPasswordTextField.tapAction = { [weak self] in
            guard let strongself = self else { return }
            strongself.renderigAgainPassword()
        }
        let kullaniciSozlesmesiGesture : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tappedKullanıcıSoz(img:)))
        self.kullaniciSozlesmesiImageView.isUserInteractionEnabled = true
        self.kullaniciSozlesmesiImageView.addGestureRecognizer(kullaniciSozlesmesiGesture)
        
    }
   
    func tappedKullanıcıSoz(img : AnyObject){
        self.performSegue(withIdentifier: "goToUserAgreement", sender: nil)
        GlobalData.bufferEmail = self.mailTextField.text!
        GlobalData.bufferName = self.nameTextField.text!
        GlobalData.bufferPass = self.passTextField.text!
        GlobalData.bufferAgainPass = self.againPasswordTextField.text!
    }
    
    func renderigSozlesmesi() {
        self.kullaniciSozButton.setTitleColor(UIColor.gray.withAlphaComponent(0.7), for: .normal)
        self.kullaniciSozButton.titleLabel?.numberOfLines = 1
        self.kullaniciSozButton.titleLabel?.adjustsFontSizeToFitWidth = true
        self.kullaniciSozButton.titleLabel?.lineBreakMode = NSLineBreakMode.byClipping
        self.kullaniciSozButton.contentHorizontalAlignment = .left
        
        
        if GlobalData.kullaniciSozlesmesiKey == "0" {
            let kullaniciSozImage = UIImage(named: "check")
            let kullanicitintedImage = kullaniciSozImage?.withRenderingMode(.alwaysTemplate)
            kullaniciSozlesmesiImageView.image = kullanicitintedImage
            kullaniciSozlesmesiImageView.tintColor = UIColor.gray.withAlphaComponent(0.7)
            print("Kullanici Tapped")
        }
        else if GlobalData.kullaniciSozlesmesiKey == "1" {
            let kullaniciSozImage = UIImage(named: "checked")
            let kullanicitintedImage = kullaniciSozImage?.withRenderingMode(.alwaysTemplate)
            kullaniciSozlesmesiImageView.image = kullanicitintedImage
            kullaniciSozlesmesiImageView.tintColor = UIColor.gray.withAlphaComponent(0.7)
            print("Kullanici Tapped")
        }
    }
    
    
    @IBAction func haydiBaslayalimButtonAction(_ sender: Any) {
        self.textFieldRegexHelp()
    }
    
    @IBAction func loginWithFacebookAction(_ sender: Any) {
        
    }
    
    @IBAction func kullaniciSozlesmesiAction(_ sender: Any) {
        self.performSegue(withIdentifier: "goToUserAgreement", sender: nil)
        GlobalData.bufferEmail = self.mailTextField.text!
        GlobalData.bufferName = self.nameTextField.text!
        GlobalData.bufferPass = self.passTextField.text!
        GlobalData.bufferAgainPass = self.againPasswordTextField.text!
    }
    
    
    @IBOutlet weak var backArrowButton: UIButton!
    @IBOutlet weak var kullaniciSozlesmesiImageView: UIImageView!
    @IBOutlet weak var againPassImageView: UIImageView!
    @IBOutlet weak var girisYapButton: UIButton!
    @IBOutlet weak var kayıtOlButton: UIButton!
    @IBOutlet weak var gsmImageView: UIImageView!
    @IBOutlet weak var emailImageView: UIImageView!
    @IBOutlet weak var isimIconUIimageView: UIImageView!
    @IBOutlet weak var nameTextField: AnimatedTextInput!
    @IBOutlet weak var mailTextField: AnimatedTextInput!
    @IBOutlet weak var passTextField: AnimatedTextInput!
    @IBOutlet weak var againPasswordTextField: AnimatedTextInput!
    @IBOutlet weak var kullaniciSozButton: UIButton!
    var referenceCode = ""
    //Service Veriable
    var registerService : RegisterService = RegisterService()
    
}

extension RegisterController : RegisterServiceDelegate {
    
    func getError() {
        self.removeProgress(customView: self.view)
        print("Error")
    }
    func getRegisterService(response: RegisterServiceResponseModel) {
       print(response)
        self.removeProgress(customView: self.view)
        if response.Error == "false" {
            UserPrefence.saveUserMail(mail: response.Email )
            UserPrefence.saveUserLoginStatus(isLogin: true)
            UserPrefence.saveUserId(id: response._id)
            UserPrefence.saveRefNo(id: response.RefNo)
            performSegue(withIdentifier: "goToMainController", sender: nil)
            GlobalData.bufferEmail = ""
            GlobalData.bufferName = ""
            GlobalData.bufferPass = ""
            GlobalData.bufferAgainPass = ""
            GlobalData.kullaniciSozlesmesiKey = ""
        }
        else{
            self.view.makeToast(response.Message)
        }
       
    }
    
}





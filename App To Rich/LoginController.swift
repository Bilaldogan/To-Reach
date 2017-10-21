//
//  LoginController.swift
//  CineBul
//
//  Created by Baran on 1.05.2017.
//  Copyright © 2017 CaWeb. All rights reserved.
//

import UIKit

class LoginController: BaseController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTappedTo()
        self.fullBlackImage()
        self.textFieldsProperties()
      
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loginButton.layoutIfNeeded()
        objectFrame = self.view.convert(loginButton.frame, from: loginButton.superview)
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
        
        mailTextField.tapAction = { [weak self] in
            guard let strongself = self else { return }
            strongself.renderigEmail()
        }
        
        passTextField.tapAction = { [weak self] in
            guard let strongself = self else { return }
            strongself.renderigGsm()
        }
        
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        self.textFieldRegexHelp()
        
    }
    @IBAction func haydiBaslayalimButtonAction(_ sender: Any) {
       
    }
    @IBAction func forgotPassAction(_ sender: Any) {
        self.showMessagePopup()
    }
    
    @IBOutlet weak var gsmImageView: UIImageView!
    @IBOutlet weak var emailImageView: UIImageView!
    
    @IBOutlet weak var mailTextField: AnimatedTextInput!
    @IBOutlet weak var passTextField: AnimatedTextInput!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    //Service Veriable 
    var loginService : LoginService = LoginService()

}

extension LoginController: LoginServiceDelegate {
    
    func getError() {
        self.removeProgress(customView: self.view)
        print("Error")
    }
    func getLoginService(response: RegisterServiceResponseModel) {
        print(response)
        self.removeProgress(customView: self.view)
        if response.Error == "false" {
            UserPrefence.saveUserMail(mail: response.Email )
            UserPrefence.saveUserLoginStatus(isLogin: true)
            UserPrefence.saveUserId(id: response._id)

            performSegue(withIdentifier: "loginTorRootVC", sender: nil)
        } else {
            self.view.makeToast(response.Message)
        }

    }
    
}





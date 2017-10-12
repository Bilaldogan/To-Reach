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
        self.keyboardEvents()
        self.addTappedTo()
        self.fullBlackImage()
        self.textFieldsProperties()

    }
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
        print("Error")
    }
    func getLoginService(response: RegisterServiceResponseModel) {
        print(response)
        performSegue(withIdentifier: "loginTorRootVC", sender: nil)

    }
    
}





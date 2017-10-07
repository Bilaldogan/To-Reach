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
        self.radiusSettings()
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
    
    
    
    
    private func radiusSettings(){
        self.loginButton.layer.cornerRadius = self.loginButton.frame.height / 2
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        self.textFieldRegexHelp()
        
    }
    @IBAction func haydiBaslayalimButtonAction(_ sender: Any) {
       
    }
    
    @IBOutlet weak var gsmImageView: UIImageView!
    @IBOutlet weak var emailImageView: UIImageView!
    
    @IBOutlet weak var mailTextField: AnimatedTextInput!
    @IBOutlet weak var passTextField: AnimatedTextInput!
    
    @IBOutlet weak var loginButton: UIButton!
    //Service Veriable 
    var registerService : RegisterService = RegisterService()

}

extension LoginController : RegisterServiceDelegate {
    
    func getError() {
        print("Error")
    }
    func getRegisterService(response: RegisterServiceResponseModel) {
        print(response)
        performSegue(withIdentifier: "loginTorRootVC", sender: nil)
        
    }
    
}





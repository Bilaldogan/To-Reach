//
//  WelcomeController.swift
//  App To Rich
//
//  Created by bilal on 07/10/17.
//  Copyright © 2017 bilal. All rights reserved.
//
import UIKit
import FacebookLogin
import FBSDKCoreKit

class WelcomeController: BaseController {
    
    @IBOutlet weak var texFieldReferenceCode: CustomTextField!
    @IBOutlet weak var loginButton: CustomButton!
    @IBOutlet weak var registerButtonLeading: NSLayoutConstraint!
    @IBOutlet weak var lblOr: UILabel!
    
    let welcomeToRegister = "WelcomeToRegister"
    
    //Service Veriable
    var registerService : RegisterService = RegisterService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        texFieldReferenceCode.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func facebookLoginAction(_ sender: Any) {
        let loginManager = LoginManager()
        loginManager.logIn([ .publicProfile,.email ], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success( _, _, let accessToken):
                print("Logged in! :", accessToken.userId!)
                
                let request = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, email, picture"])
                
                
                let _ = request?.start(completionHandler: { (connection, result, error) in
                    
                    guard let userInfo = result as? [String: Any] else { return } //handle the error
                    
                    guard let userName = userInfo["name"] as? String else{
                        return
                    }
                    guard let facebookId = userInfo["id"] as? String else{
                        return
                    }
                    guard let userEmail = userInfo["email"] as? String else{
                        return
                    }
                    guard let userID = accessToken.userId else{
                        return
                    }
                    guard let _ : String = "https://graph.facebook.com/\(userID)/picture?type=large" else{
                        return
                    }
                    
                    self.registerService.serviceDelegate = self
                    var sendModel : RegisterServiceSendData = RegisterServiceSendData()
                    sendModel.UserEmail = userEmail
                    sendModel.UserName = userName
                    sendModel.MacId = UIDevice.current.identifierForVendor!.uuidString
                    sendModel.OneSignalId = UserPrefence.getOneSignalId()
                    sendModel.RefNo = self.texFieldReferenceCode.text!
                    sendModel.FaceBookId = facebookId
                    
                    self.showProgressView()
                    if self.hasConnectivity() {
                        self.registerService.dispatchGetService(model: sendModel)
                    } else {
                        // Message Göster
                    }
                    
                    
                })
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? RegisterController {
            destinationVC.referenceCode = texFieldReferenceCode.text!
        }
    }
    
    
}
extension WelcomeController: UITextFieldDelegate {
    func textFieldDidChange(_ textField: UITextField) {
        
        if self.texFieldReferenceCode.text != nil, self.texFieldReferenceCode.text != ""  {
            
            UIView.animate(withDuration: 0.5, animations: {
                self.registerButtonLeading.constant = -self.loginButton.frame.width - self.lblOr.frame.width
                self.loginButton.alpha = 0.1
                self.view.layoutIfNeeded()
            }){ success in
                self.loginButton.isHidden = true
                
            }
        }
        else{
            UIView.animate(withDuration: 0.5, animations: {
                self.registerButtonLeading.constant = 0
                self.loginButton.alpha = 1.0
                self.loginButton.isHidden = false
                self.view.layoutIfNeeded()
            })
            
        }
        
    }
    
}

extension WelcomeController : RegisterServiceDelegate {
    
    func getError() {
        self.removeProgress(customView: self.view)
        print("Error")
    }
    func getRegisterService(response: RegisterServiceResponseModel) {
        self.removeProgress(customView: self.view)
        if response.Message == "Kayıt başarılı olarak alınmıştır." {
            UserPrefence.saveUserId(id: response._id)
            performSegue(withIdentifier: "goToMainController", sender: nil)
        }
        else{
            
        }
    }
    
}

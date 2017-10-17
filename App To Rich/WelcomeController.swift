//
//  WelcomeController.swift
//  App To Rich
//
//  Created by bilal on 07/10/17.
//  Copyright © 2017 bilal. All rights reserved.
//

import UIKit

class WelcomeController: BaseController {

    @IBOutlet weak var texFieldReferenceCode: CustomTextField!
    
    @IBOutlet weak var loginButton: CustomButton!

    @IBOutlet weak var registerButtonLeading: NSLayoutConstraint!
    
    @IBOutlet weak var lblOr: UILabel!
    
    let welcomeToRegister = "WelcomeToRegister"
    override func viewDidLoad() {
        super.viewDidLoad()

        texFieldReferenceCode.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

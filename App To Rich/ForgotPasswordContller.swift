//
//  ForgotPasswordContller.swift
//  App To Rich
//
//  Created by bilal on 12/10/17.
//  Copyright © 2017 bilal. All rights reserved.
//

import Foundation
import UIKit
class ForgotPasswordController: BaseController{
    
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
        
        
        
    }
    
    @IBOutlet weak var emailImageView: UIImageView!
    
    @IBOutlet weak var mailTextField: AnimatedTextInput!
   
    
   
    
}

extension ForgotPasswordController : ForgotPasswordServiceDelegate {
    
    func getError() {
        print("Error")
    }
    func getForgorService(status: String) {
    }
    
    
}

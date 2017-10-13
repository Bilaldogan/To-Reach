//
//  MessagePopupController.swift
//  fitwin
//
//  Created by Baran on 21.09.2017.
//  Copyright © 2017 Brainilission. All rights reserved.
//

import Foundation
import UIKit

class MessagePopupController: BaseController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTapped()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        self.blurView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        self.blurEffect(customView: self.blurView)
        self.popUpView.layer.cornerRadius = 10.0
        
        self.textFieldsProperties()
        
        
        //self.blurView.translatesAutoresizingMaskIntoConstraints = true
        
    }
    
    override func viewWillLayoutSubviews() {
        
        self.textFieldsFrontEnd()
    }
    
    override func viewDidLayoutSubviews() {
        self.bottomLeftAndRightradiusSettings(viewToRound: okeyButton)
    }
    
    private func addTapped(){
        
        let closePopUpGesture : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.closePopUp))
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(closePopUpGesture)
        
        mailTextField.tapAction = { [weak self] in
            guard let strongself = self else { return }
            strongself.renderigEmail()
        }
    }
    func closePopUp(){
        
        UIView.animate(withDuration: 0.35, animations: {
            self.popUpView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            self.popUpView.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }
    
    
   
    
    @IBAction func OkeyButtonAction(_ sender: Any) {
        self.forgotService.serviceDelegate = self
        self.forgotService.dispatchGetService(with: self.mailTextField.text!)
    
    }
    
    internal func renderigEmail() {
        emailImageView.imageViewRendering(imageNamed: "at", imageColor: ColorUtil.pinkColor)
    }
   
    internal func textFieldsProperties(){
        
        mailTextField.backgroundColor = UIColor.clear
        mailTextField.accessibilityLabel = "standard_text_input"
        mailTextField.placeHolderText = "E-posta adresiniz"
        mailTextField.textColor = UIColor.white
        mailTextField.type = .email
        mailTextField.style = CustomTextInputStyle()
        
    }
    
    internal func textFieldsFrontEnd(){
        
        mailTextField.style.marginPosition = self.emailImageView.frame.width
        mailTextField.contentInset = UIEdgeInsetsMake(22.5, 0, 0, 0)
        mailTextField.addResponsiveFont(fontSize: 13)
        mailTextField.style.placeholderSelfPosition = 22.5 + (self.emailImageView.frame.height / 4)

    }
    
    
    @IBOutlet weak var emailImageView: UIImageView!
    @IBOutlet weak var mailTextField: AnimatedTextInput!
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var okeyButton: UIButton!
    @IBOutlet weak var blurView: UIView!
    var forgotService = ForgotPasswordService()
}
extension MessagePopupController : ForgotPasswordServiceDelegate {
    func getError() {
        
    }
    func getForgorService(status: String) {
        if status == "false" {
            self.closePopUp()
        }
    }
}

//
//  PopUpTrasnferController.swift
//  App To Rich
//
//  Created by bilal on 17/10/2017.
//  Copyright © 2017 bilal. All rights reserved.
//

import UIKit

class PopUpTransferController: BaseController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTapped()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        self.blurView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        self.blurEffect(customView: self.blurView)
        self.popUpView.layer.cornerRadius = 10.0
        //self.blurView.translatesAutoresizingMaskIntoConstraints = true
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        objectFrame = self.view.convert(okeyButton.frame, from: okeyButton.superview)
        isScreenWillMove = true
    }
    override func viewWillLayoutSubviews() {
        
    }
    
    override func viewDidLayoutSubviews() {
       // self.bottomLeftAndRightradiusSettings(viewToRound: okeyButton)
    }
    
    private func addTapped(){
        
        let closePopUpGesture : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.closePopUp))
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(closePopUpGesture)
        
       
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
    
    
    
    
    
    internal func renderigEmail() {
        emailImageView.imageViewRendering(imageNamed: "at", imageColor: ColorUtil.pinkColor)
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

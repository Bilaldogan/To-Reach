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
        transferService.serviceDelegate = self
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        objectFrame = self.view.convert(okeyButton.frame, from: okeyButton.superview)
        isScreenWillMove = true
    }
    override func viewWillLayoutSubviews() {
        
    }
   
    override func viewDidLayoutSubviews() {
        //self.bottomLeftAndRightradiusSettings(viewToRound: okeyButton)
    }
    
    @IBAction func okeyTapped(_ sender: UIButton) {
         if hasConnectivity() {
            if lblGSM.text?.isEmpty == false {
                    self.showProgressView()
                    var model = TransferServiceSendData()
                    model.amount = ""
                    model.ibanNo = ""
                    model.gSM = lblGSM.text!
                    transferService.dispatchGetService(model: model)
            }
            else{
                self.view.endEditing(true)
                self.self.view.makeToast("Lütfen bilgileri eksiksiz doldurunuz")
            }
            
        } else {
            self.view.endEditing(true)
            self.view.makeToast("Lütfen internet bağlantınızı kontrol ediniz.")
            //message Göster
        }
    }
    
    private func addTapped(){
        
        let closePopUpGesture : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.closePopUp))
        self.blurView.isUserInteractionEnabled = true
        self.blurView.addGestureRecognizer(closePopUpGesture)
        
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
    
    var transferService : TransferService = TransferService()
    var userPrice = 0
    
    @IBOutlet weak var lblGSM: UITextField!
    @IBOutlet weak var lblIBAN: UITextField!
    
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var okeyButton: UIButton!
    @IBOutlet weak var blurView: UIView!
}
extension PopUpTransferController : TransferServiceDelegate {
    func getError() {
        self.removeProgress(customView: self.view)
    }
    func getTrasnferService(status: String) {
        self.removeProgress(customView: self.view)
        if status == "true" {
            self.view.makeToast("işleminiz başarı ile gerçekleştrildi.")
            let when = DispatchTime.now() + 2 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.closePopUp()
            }
            
        } else {
            self.view.makeToast("işleminiz şuanda gerçekleştirilemiyor")
        }


    }

    
}

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
    @IBAction func okeyTapped(_ sender: UIButton) {
        self.showProgressView()
        if hasConnectivity() {
            var model = TransferServiceSendData()
            model.ibanNo = lblIBAN.text!
            model.gSM = lblGSM.text!
            transferService.dispatchGetService(model: model)
        } else {
            self.view.makeToast("Lütfen internet bağlantınızı kontrol ediniz.")
            //message Göster
        }
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
    
    var transferService : TransferService = TransferService()

    
    @IBOutlet weak var lblGSM: UITextField!
    @IBOutlet weak var lblIBAN: UITextField!
    
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
        } else {
            self.view.makeToast("işleminiz şuanda gerçekleştirilemiyor")
        }


    }

    
}

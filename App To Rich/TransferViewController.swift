//
//  TransferViewController.swift
//  App To Rich
//
//  Created by bilal on 16/10/2017.
//  Copyright © 2017 bilal. All rights reserved.
//

import UIKit

class TransferViewController: BaseController {
    
    @IBOutlet weak var downView: UIView!
    
    var userprofileService : UserProfileService = UserProfileService()
    var transferService : TransferService = TransferService()
    
    @IBOutlet weak var lblCoins: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startProfileService()
        downView.layer.cornerRadius = 20.0
        transferService.serviceDelegate = self
    }
    @IBAction func confirmButtonTapped(_ sender: Any) {
        if Int(Double(self.lblCoins.text!)!) < 100000 {
            self.view.makeToast("İletişime geçebilmek için yeterli puanınız bulunmamaktadır.")
        }
        else{
//            if hasConnectivity() {
//                self.showProgressView()
//                var model = TransferServiceSendData()
//                model.amount = ""
//                model.ibanNo = ""
//                model.gSM = ""
//                transferService.dispatchGetService(model: model)
//            } else {
//                self.view.endEditing(true)
//                self.view.makeToast("Lütfen internet bağlantınızı kontrol ediniz.")
//            }
            showTransferPopup()
        }
    }
    
    func startProfileService(){
        self.userprofileService.serviceDelegate = self
        self.showProgressView()
        if hasConnectivity() {
            self.userprofileService.dispatchGetService()
        }
        else {
            self.view.makeToast("Lütfen internet bağlantınızı kontrol ediniz.")
        }
    }
    
}

extension TransferViewController: UserProfileServiceDelegate {
    func getError() {
        self.removeProgress(customView: self.view)
        
    }
    func getUserProfileService(response: UserProfileServiceResponseModel) {
        if response.error == "false" {
            self.lblCoins.text = response.coins
        }
        else{
            self.view.makeToast(response.message)
        }
        self.removeProgress(customView: self.view)
        print(response)
    }
}

extension TransferViewController : TransferServiceDelegate {
    func getTrasnferService(status: String) {
        self.removeProgress(customView: self.view)
        if status == "true" {
            self.view.makeToast("işleminiz başarı ile gerçekleştrildi.")
        } else {
            self.view.makeToast("işleminiz şuanda gerçekleştirilemiyor")
        }
    }
}
extension TransferViewController {
    
    func showTransferPopup(){
        DispatchQueue.main.async {
            let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PopUpTrasferController") as! PopUpTransferController
            popOverVC.view.tag = 101
            popOverVC.userPrice = Int(Double(self.lblCoins.text!)!)
            self.addChildViewController(popOverVC)
            popOverVC.view.frame = self.calculatePopupFrame()
            self.view.addSubview(popOverVC.view)
            popOverVC.didMove(toParentViewController: self)
            
            popOverVC.popUpView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            popOverVC.popUpView.alpha = 0.0;
            UIView.animate(withDuration: 0.35, animations: {
                popOverVC.popUpView.alpha = 1.0
                popOverVC.popUpView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            });
        }
    }
    
    func removePopup2(customView : UIView){
        DispatchQueue.main.async {
            //print("Start remove sibview")
            if let viewWithTag = customView.viewWithTag(101) {
                UIView.animate(withDuration: 0.35, animations: {
                    viewWithTag.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                    viewWithTag.alpha = 0.0;
                }, completion:{(finished : Bool)  in
                    if (finished)
                    {
                        viewWithTag.removeFromSuperview()
                    }
                });
                
            }else{
                print("No!")
            }
        }
    }
    
}

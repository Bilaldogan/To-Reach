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
    
    @IBOutlet weak var lblCoins: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startProfileService()
        downView.layer.cornerRadius = 20.0
    }
    @IBAction func confirmButtonTapped(_ sender: Any) {
            showTransferPopup()
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
extension TransferViewController {
    
    func showTransferPopup(){
        DispatchQueue.main.async {
            let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PopUpTrasferController") as! PopUpTransferController
            popOverVC.view.tag = 101
            self.addChildViewController(popOverVC)
            popOverVC.view.frame = self.view.frame
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

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
    override func viewDidLoad() {
        super.viewDidLoad()
        downView.layer.cornerRadius = 20.0
    }
    @IBAction func confirmButtonTapped(_ sender: Any) {
        showTransferPopup()
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

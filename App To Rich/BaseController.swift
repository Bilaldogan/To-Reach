//
//  BaseController.swift
//  CineBul
//
//  Created by Baran on 8.05.2017.
//  Copyright © 2017 CaWeb. All rights reserved.
//

import UIKit

class BaseController: UIViewController {
    
    var progressView : Progress!
    var backgroundView : UIView?
    var shareSupporter = ShareSupporter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureNavigationBar()

    }
    func leftTapped() {
       // self.presentLeftMenuViewController(nil)
    }
    func hasConnectivity() -> Bool {
        
        do {
            let reachability: Reachability = try Reachability.init()!
            let networkStatus: Int = reachability.currentReachabilityStatus.hashValue
            return (networkStatus != 0)
        }
        catch {
            // Handle error however you please
            return false
        }
    }
    
    
    func calculateTableCellHeight(rate : Double) -> Double {
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        return Double(screenWidth) * rate
    }
    
    func configureNavigationBar() {
        let button: UIButton = UIButton(type: .custom)
        
        //set image for button
        button.buttonImageRendering(imageNamed: "menu", imageColor: UIColor.white)
        //set frame
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 31)
        let barButton = UIBarButtonItem(customView: button)
        button.addTarget(self, action: #selector(self.presentRightMenuViewController(_:)), for: .touchUpInside)
        //assign button to navigationbar
        self.navigationItem.rightBarButtonItem = barButton
        self.navigationItem.rightBarButtonItem?.isEnabled = true
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    //Progress View Setup
    
    func showProgressView(){
        backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        backgroundView?.tag = 202
        backgroundView?.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        self.view.addSubview(backgroundView!)
        progressView = Progress()
        progressView.tag = 201
        self.view.addSubview(progressView)
        
    }
    
    func removeProgress(customView : UIView){
        DispatchQueue.main.async {
            //print("Start remove sibview")
            if let viewWithTag = customView.viewWithTag(201) {
                self.progressView.stopAnimatingKey = true
                viewWithTag.removeFromSuperview()
                self.progressView = nil
            }else{
                print("No!")
            }
            
            if let viewWithTag = customView.viewWithTag(202) {
                viewWithTag.removeFromSuperview()
                self.backgroundView = nil
            }else{
                print("No!")
            }
            
        }
    }
    
    func bottomLeftAndRightradiusSettings(viewToRound: UIButton){
        let path = UIBezierPath(roundedRect:viewToRound.bounds,
                                byRoundingCorners:[.bottomLeft, .bottomRight],
                                cornerRadii : CGSize(width: 10, height:  10))
        
        let maskLayer = CAShapeLayer()
        
        maskLayer.path = path.cgPath
        viewToRound.layer.mask = maskLayer
        
    }
    
    func blurEffect(customView: UIView){
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        //blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        customView.addSubview(blurEffectView)
    }
    
    
    //Show popup
    func showMessagePopup()
    {
        DispatchQueue.main.async {
            let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MessagePopupControllerID") as! MessagePopupController
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
    
    func removePopup(customView : UIView){
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

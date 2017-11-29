//
//  BaseController.swift
//  CineBul
//
//  Created by Baran on 8.05.2017.
//  Copyright © 2017 CaWeb. All rights reserved.
//

import UIKit
import Toast_Swift
class BaseController: UIViewController {
    
    var progressView : Progress!
    var backgroundView : UIView?
    var shareSupporter = ShareSupporter()
    
    var objectFrame : CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    var keyboardIsShown = false
    var isScreenWillMove : Bool = false {
        didSet {
                    let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
                    self.view.addGestureRecognizer(tap)
            NotificationCenter.default.addObserver(self, selector: #selector(BaseController.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(BaseController.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureNavigationBar()
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewDidDisappear(_ animated: Bool) {
        self.removeProgress(customView: self.view)
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
    
    func calculatePopupFrame() -> CGRect{
        let screenWidth = UIScreen.main.bounds.width
        var screenHeight : CGFloat = 0
        if self.navigationController?.navigationBar != nil {
        screenHeight = UIScreen.main.bounds.height - (self.navigationController?.navigationBar.intrinsicContentSize.height)! - UIApplication.shared.statusBarFrame.height
        }
        let rect = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        return rect
    }
    
    func calculateTableCellHeight(rate : Double) -> Double {
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        return Double(screenWidth) * rate
    }
    
    func configureMainPageNovBar(amount: String) {
        let button = UIButton.init(type: .custom)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        let imageView = UIImageView(frame: CGRect(x: 5, y: 5, width: 25, height: 25))
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor.clear
        imageView.image = UIImage(named: "money")
        let label = UILabel(frame: CGRect(x: 30, y: 0, width: 50, height: 35))
        label.minimumScaleFactor = 3.0 / 10.0
        label.adjustsFontSizeToFitWidth = true
        label.text = amount
        label.baselineAdjustment = .alignCenters
        label.textColor = UIColor.white
        let buttonView = UIView(frame: CGRect(x: 0, y: 0, width: 85, height: 35))
        button.frame = buttonView.frame
        button.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        button.layer.cornerRadius = 5.0
        button.layer.masksToBounds = true
        buttonView.addSubview(button)
        buttonView.addSubview(imageView)
        buttonView.addSubview(label)
        let barButton = UIBarButtonItem.init(customView: buttonView)
        self.navigationItem.leftBarButtonItem = barButton
    }
    
    func buttonPressed(){
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let myProfileVC = storyboard.instantiateViewController(withIdentifier: "AccounDetailControllerID") as! AccounDetailController
        let obj : UINavigationController = self.sideMenuViewController?.contentViewController as! UINavigationController
        obj .pushViewController(myProfileVC, animated: true)
        self.sideMenuViewController!.hideMenuViewController()
    }
    
    func configureNavigationBar() {
        let button: UIButton = UIButton(type: .custom)
        
        //set image for button
        button.buttonImageRendering(imageNamed: "menu", imageColor: UIColor.white)
        //set frame
        button.frame = CGRect(x: 0, y: 0, width: 20, height: 31)
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
    func showNoticePopup(Title item: String , Description text: String)
    {
            let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NoticePopupControllerID") as! NoticePopupController
            popOverVC.descText = text
            popOverVC.titleText = item
            popOverVC.view.tag = 101
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
    
    func keyboardWillShow(notification: NSNotification) {
        if isScreenWillMove {
            if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if !keyboardIsShown {
                    
                    let moveSize = keyboardSize.size.height - (self.view.frame.height - objectFrame.maxY ) + 5
                    
                        if keyboardSize.height > (self.view.frame.height - objectFrame.maxY) {
                        //self.view.frame.origin.y -=  moveSize
                        
                        if keyboardSize.height > (moveSize) {
                            
                            self.view.frame.origin.y -=  moveSize
                            
                        }
                        keyboardIsShown = true
                    }
                }
            }
            
        }
    }
    
    //Layer Settings 
    func bottomRightradiusSettings(viewToRound: UIButton){
        let path = UIBezierPath(roundedRect:viewToRound.bounds,
                                byRoundingCorners:[.bottomRight],
                                cornerRadii: CGSize(width: 10, height:  10))
        
        let maskLayer = CAShapeLayer()
        
        maskLayer.path = path.cgPath
        viewToRound.layer.mask = maskLayer
        
    }
    func bottomLeftradiusSettings(viewToRound: UIButton){
        let path = UIBezierPath(roundedRect:viewToRound.bounds,
                                byRoundingCorners:[.bottomLeft],
                                cornerRadii : CGSize(width: 10, height:  10))
        
        let maskLayer = CAShapeLayer()
        
        maskLayer.path = path.cgPath
        viewToRound.layer.mask = maskLayer
        
    }
   
    
    //******
    func keyboardWillHide(notification: NSNotification) {
        if ((notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            if keyboardIsShown {
                self.view.frame.origin.y = 0.0
                keyboardIsShown = false
            }
        }
        
    }
    func dismissKeyboard() {
        
        view.endEditing(true)
    }
    
}

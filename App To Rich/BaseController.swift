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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"kullanici"), style: .plain, target: self, action: #selector(self.presentLeftMenuViewController(_:)))
        //navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"kullanici"), style: .plain, target: self, action: #selector(self.presentRightMenuViewController(_:)))

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
    
    
    //Progress View Setup
    
    func showProgressView(){
        let backgroundView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        backgroundView.tag = 102
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        self.view.addSubview(backgroundView)
        progressView = Progress()
        progressView.tag = 101
        self.view.addSubview(progressView)
    }
    
    func removeProgress(customView : UIView){
        DispatchQueue.main.async {
            //print("Start remove sibview")
            if let viewWithTag = customView.viewWithTag(101) {
                viewWithTag.removeFromSuperview()
            }else{
                print("No!")
            }
            
            if let viewWithTag = customView.viewWithTag(102) {
                viewWithTag.removeFromSuperview()
            }else{
                print("No!")
            }
            
        }
    }
    
    
    
    
}

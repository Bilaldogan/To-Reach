//
//  BaseController.swift
//  CineBul
//
//  Created by Baran on 8.05.2017.
//  Copyright © 2017 CaWeb. All rights reserved.
//

import UIKit


class BaseController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"kullanici"), style: .plain, target: self, action: #selector(self.presentLeftMenuViewController(_:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"kullanici"), style: .plain, target: self, action: #selector(self.presentRightMenuViewController(_:)))

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
 
    
}

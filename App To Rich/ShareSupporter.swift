//
//  ShareSupporter.swift
//  App To Rich
//
//  Created by Baran on 16.10.2017.
//  Copyright © 2017 bilal. All rights reserved.
//

import UIKit

class ShareSupporter: NSObject {
    
    func globalShare(viewController : UIViewController){
        let activityVC = UIActivityViewController(activityItems: ["AppToRich"], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = viewController.view
        DispatchQueue.main.async(execute: {
            viewController.present(activityVC, animated: true, completion: nil)
        })
        
    }
    
    
}

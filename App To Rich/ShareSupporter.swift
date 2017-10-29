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
        let shareText = "Merhaba AppToRich uygulamasında hep beraber para kazanmaya ne dersin sadece verilen görevleri yap ve puanları topla. Bu arada benim referans numaram ile kayıt olursan çok sevinirim. Referans Numaram : \(UserPrefence.getRefNo())"
        let activityVC = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = viewController.view
        DispatchQueue.main.async(execute: {
            viewController.present(activityVC, animated: true, completion: nil)
        })
        
    }
    
    
}

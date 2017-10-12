//
//  WebViewController.swift
//  App To Rich
//
//  Created by Baran on 12.10.2017.
//  Copyright © 2017 bilal. All rights reserved.
//

import UIKit

class WebViewController: BaseController, UIWebViewDelegate {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(web_link)
        webView.delegate = self
        if let url = URL(string: "https://" + web_link) {
            let request = URLRequest(url: url)
            webView.loadRequest(request)
        }
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        if !webView.isLoading{
            self.startAdwerdService()
            return
        }
        print("Done loading")
    }
    
    func startAdwerdService(){
        self.clickAdwerdService.serviceDelegate = self
        var sendData : ClickAdwerdSendData = ClickAdwerdSendData()
        sendData.AppId = self.web_id
        sendData.UserId = UserPrefence.getUserId()
        print(sendData)
        self.clickAdwerdService.dispatchGetService(model: sendData)
    }
    
    
    @IBOutlet weak var webView: UIWebView!
    var web_link : String = ""
    var web_id : String = ""

    //Service Veriable
    var clickAdwerdService : ClickAdwerdService = ClickAdwerdService()
    
    
}

extension WebViewController : ClickAdwerdServiceDelegate {
    
    func getError() {
        
    }
    func getUserProfileService(response: ClickAdwerdResponseModel) {
        print("Response Model :", response)
        self.clickAdwerdService.serviceDelegate = nil
    }
    
}

//
//  AdvertController.swift
//  App To Rich
//
//  Created by bilal on 30/09/17.
//  Copyright © 2017 bilal. All rights reserved.
//

import UIKit

class AdvertController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    var advertURL : URL?
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.delegate = self
        let url = URL(string: "http://stackoverflow.com")
        let request = URLRequest(url: url! )
        webView.loadRequest(request)
    }



}
extension AdvertController : UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        print("sayfa yüklendi")
    }
}

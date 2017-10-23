//
//  KullaniciSozlesmesiController.swift
//  CineBul
//
//  Created by Baran on 23.05.2017.
//  Copyright © 2017 CaWeb. All rights reserved.
//

import UIKit

class KullaniciSozlesmesiController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    override func viewWillAppear(_ animated: Bool) {
      navigationController?.navigationBar.isHidden = true // for navigation bar hide
    }
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    override func viewWillLayoutSubviews() {
        kullaniciSozlesmesiTextField.setContentOffset(CGPoint.zero, animated: false)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func kabulEdiyorumAction(_ sender: Any) {
        GlobalData.kullaniciSozlesmesiKey = "1"
        self.performSegue(withIdentifier: "sozlesmeToRegisterController", sender: nil)
    }

    @IBAction func kabulEtmiyorumAction(_ sender: Any) {
        GlobalData.kullaniciSozlesmesiKey = "0"
        self.performSegue(withIdentifier: "sozlesmeToRegisterController", sender: nil)
    }
    
    @IBOutlet weak var kullaniciSozlesmesiTextField: UITextView!
    

}

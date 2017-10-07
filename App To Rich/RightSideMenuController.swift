//
//  RightSideMenuController.swift
//  App To Rich
//
//  Created by Baran on 7.10.2017.
//  Copyright © 2017 bilal. All rights reserved.
//

import UIKit

class RightSideMenuController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    
    var tableView: UITableView?
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        switch UIDevice.current.userInterfaceIdiom{
        case .pad:
            self.tableView = UITableView.init(frame: CGRect(x: 0, y: (self.view.frame.size.height - 94 * 6) / 2.0, width: self.view.frame.size.width, height: 100 * 6), style: UITableViewStyle.plain)
            
        case .phone:
            self.tableView = UITableView.init(frame: CGRect(x: 0, y: (self.view.frame.size.height - 50 * 6) / 2.0, width: self.view.frame.size.width, height: 54 * 6), style: UITableViewStyle.plain)
        default:
            break
        }
        
        
        tableView?.autoresizingMask = [UIViewAutoresizing.flexibleTopMargin, UIViewAutoresizing.flexibleBottomMargin, UIViewAutoresizing.flexibleWidth]
        
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.isOpaque = false
        tableView?.backgroundColor = UIColor.clear
        tableView?.backgroundView = nil
        tableView?.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView?.bounces = false
        tableView?.scrollsToTop = false
        self.view.backgroundColor = UIColor.clear
        
        
        self.view.addSubview(self.tableView!)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        
    }
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("RightMenuCustomCell", owner: self, options: nil)?.first as! RightMenuCustomCell
        cell.customLabel.text = labelTextArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch UIDevice.current.userInterfaceIdiom{
        case .pad:
            return 100
        case .phone:
            return 54
        default:
            return 54
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        
        
    }
    
//    func goToAboutUsController(){
//        self.sideMenuViewController!.setContentViewController(UINavigationController.init(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "aboutUsControllerID")), animated: true)
//        self.sideMenuViewController!.hideMenuViewController()
//    }
    
    
    let imageArray : Array = ["ev","liste","kilit","question","uyari","odul","cikis"]
    let labelTextArray : Array = ["ANASAYFA","PROFİLİM","PAYLAŞ","KAZAN","TRANSFER","ÇIKIŞ YAP"]
    
    
    
}

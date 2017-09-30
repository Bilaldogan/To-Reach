//
//  RigtMenuController.swift
//  App To Rich
//
//  Created by bilal on 29/09/17.
//  Copyright © 2017 bilal. All rights reserved.
//

import UIKit

class RigtMenuController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let menuText = ["ANASAYFA", "HESABIM", "DAHA FAZLA PAYLAŞ", "DAHA FAZLA KAZAN","ÇIKIŞ YAP"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.isScrollEnabled = false
    }

    
}
extension RigtMenuController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = menuText[indexPath.row]
        cell.textLabel?.textColor = UIColor.lightGray
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuText.count
    }
}

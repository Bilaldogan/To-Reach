//
//  ViewController.swift
//  App To Rich
//
//  Created by bilal on 26/09/17.
//  Copyright © 2017 bilal. All rights reserved.
//

import UIKit

class UserTreeController: BaseController {

    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    


}
extension UserTreeController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "childUserCell", for: indexPath) as? ChildUserCell {
            return cell
        }
        return UITableViewCell()
    
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 15
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
}

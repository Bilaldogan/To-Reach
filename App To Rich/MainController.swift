//
//  MainController.swift
//  App To Rich
//
//  Created by bilal on 28/09/17.
//  Copyright © 2017 bilal. All rights reserved.
//

import UIKit

class MainController: BaseController {

    @IBOutlet weak var tableView: UITableView!
    
    var nextVC = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
       
    }
}
extension MainController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "advertCell", for: indexPath) as? AdvertCell {
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }


}

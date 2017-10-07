//
//  AccounDetailController.swift
//  App To Rich
//
//  Created by bilal on 30/09/17.
//  Copyright © 2017 bilal. All rights reserved.
//

import UIKit

class AccounDetailController: BaseController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var descriptionViewHeight: NSLayoutConstraint!
    
    var lastContentOffset: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

  
}
extension AccounDetailController :UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "childUserCell", for: indexPath) as? ChildUserCell {
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
      resizeDescriptionView()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func resizeDescriptionView () {
        if (self.lastContentOffset > self.tableView.contentOffset.y) && self.tableView.contentOffset.y < 0 {
            
            if descriptionViewHeight.constant <= 468 {
                self.descriptionViewHeight.constant -= self.tableView.contentOffset.y
                
                self.view.layoutIfNeeded()
            }
            
        }
        else if (self.lastContentOffset < self.tableView.contentOffset.y) && self.tableView.contentOffset.y > 0 {
            if  descriptionViewHeight.constant >= 0 {
                self.descriptionViewHeight.constant -= self.tableView.contentOffset.y
                self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0) , at: .top, animated: true)
                self.view.layoutIfNeeded()
            }
        }
        self.lastContentOffset = self.tableView.contentOffset.y

    }
}

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
    
    //Service Veriable
    var mainService : MainService = MainService()
    
    //Service response
    var adwerdListResponse : [MainServiceResponseList] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.startMainService(pageNumber: "1")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
    
    }
    
    func startMainService(pageNumber : String){
        self.mainService.serviceDelegate = self
        var sendModel : MainServiceSendData = MainServiceSendData()
        sendModel.PageNumber = pageNumber
        sendModel.UserId = "0"
        self.mainService.dispatchGetService(model: sendModel)
        self.showProgressView()
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
        return CGFloat(self.calculateTableCellHeight(rate: 0.2801))
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }

}

extension MainController : MainServiceDelegate {
    
    func getError() {
        
    }
    
    func getMainService(response: MainServiceResponseModel) {
        print(response)
        self.adwerdListResponse = response.adwerdList
        self.tableView.reloadData()
        self.removeProgress(customView: self.view)
    }
    
}


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
    var _idClickedAdwerd : String = ""
    var _linkClickedAdwerd : String = ""
    
    
    //Service Veriable
    var mainService : MainService = MainService()
    
    //Service response
    var adwerdListResponse : MainServiceResponseModel = MainServiceResponseModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.sectionHeaderHeight = 0.00001
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.startMainService(pageNumber: "1")
    }
    
    func startMainService(pageNumber : String){
        self.mainService.serviceDelegate = self
        var sendModel : MainServiceSendData = MainServiceSendData()
        sendModel.PageNumber = pageNumber
        sendModel.UserId = "0"
        self.mainService.dispatchGetService(model: sendModel)
        self.showProgressView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToWebView" {
            let vc = segue.destination as! WebViewController
            vc.web_link = self._linkClickedAdwerd
            vc.web_id = self._idClickedAdwerd
        }
    }
    
}
extension MainController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "advertCell", for: indexPath) as? AdvertCell {
            cell.configure(with: self.adwerdListResponse.adwerdList[indexPath.row])
            
            
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(self.calculateTableCellHeight(rate: 0.2801))
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self._linkClickedAdwerd = adwerdListResponse.adwerdList[indexPath.row].AppUrl
        self._idClickedAdwerd = adwerdListResponse.adwerdList[indexPath.row].addwerd_id
        self.performSegue(withIdentifier: "goToWebView", sender: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return adwerdListResponse.adwerdList.count
    }

}

extension MainController : MainServiceDelegate {
    
    func getError() {
        
    }
    
    func getMainService(response: MainServiceResponseModel) {
        print(response)
        self.adwerdListResponse = response
        self.tableView.reloadData()
        self.removeProgress(customView: self.view)
    }
    
}


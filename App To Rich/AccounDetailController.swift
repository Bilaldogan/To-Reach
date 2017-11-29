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
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var refNoLabel: UILabel!
    @IBOutlet weak var coinLabel: UILabel!
    @IBOutlet weak var yourConnectLabel: UILabel!
    
    
    var lastContentOffset: CGFloat = 0
    
    //Service veriable
    var userprofileService : UserProfileService = UserProfileService()
    
    //Service response model
    var subUserArray : [SubProfileModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.startProfileService()
        self.configure()
    }
    
    func startProfileService(){
        self.userprofileService.serviceDelegate = self
        self.showProgressView()
        if hasConnectivity() {
            self.userprofileService.dispatchGetService()
        }
        else {
            self.view.makeToast("Lütfen internet bağlantınızı kontrol ediniz.")
        }
    }
    
    func configure(){
        self.shareButton.buttonImageRendering(imageNamed: "paylas", imageColor: ColorUtil.pinkColor)
        switch UIDevice.current.userInterfaceIdiom{
        case .pad:
            let HEADER_HEIGHT = 700
            tableView.tableHeaderView?.frame.size = CGSize(width: tableView.frame.width, height: CGFloat(HEADER_HEIGHT))
        default:
            break
        }
    }
    
    @IBAction func shareButtonAction(_ sender: Any) {
        self.shareSupporter.globalShare(viewController: self)
    }
    
}
extension AccounDetailController :UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "childUserCell", for: indexPath) as? ChildUserCell {
            cell.configure(with: subUserArray[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.subUserArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(self.calculateTableCellHeight(rate: 0.263))
    }

}

extension AccounDetailController : UserProfileServiceDelegate {
    func getError() {
        self.removeProgress(customView: self.view)
        
    }
    func getUserProfileService(response: UserProfileServiceResponseModel) {
        if response.error == "false" {
            self.mailLabel.text = ": " + response.email
            self.nameLabel.text = ": " + response.userName
            self.refNoLabel.text = ": " + response.refNo
            self.coinLabel.text = response.coins
        }
        else{
            self.view.makeToast(response.message)
        }
        
        if response.subProfiles.count == 1 && response.subProfiles[0].error == "true" {
            
            self.yourConnectLabel.text = "Henüz bir bağlantın bulunmamaktadır"
        }
        else{
            for subUser in response.subProfiles {
                print(subUser.error)
                if subUser.error == "false"{
                    self.subUserArray.append(subUser)
                }
            }
            print(response.subProfiles)
            self.tableView.reloadData()
        }
        
        self.removeProgress(customView: self.view)
        print(response)
    }
}

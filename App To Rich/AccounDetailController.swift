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
            
        }
    }
    
    func configure(){
        self.shareButton.buttonImageRendering(imageNamed: "paylas", imageColor: ColorUtil.pinkColor)
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
            
        }
        for subUser in response.subProfiles {
            print(subUser.error)
            if subUser.error == "false"{
                self.subUserArray.append(subUser)
            }
        }
        print(response.subProfiles)
        self.tableView.reloadData()
        
        self.removeProgress(customView: self.view)
        print(response)
    }
}

//
//  UserProfileService.swift
//  App To Rich
//
//  Created by Baran on 7.10.2017.
//  Copyright © 2017 bilal. All rights reserved.
//

import Foundation
import SWXMLHash

class UserProfileService : ConnectionDelegate
{
   	
    let connection = PostConnection()
    var serviceDelegate : UserProfileServiceDelegate?
    
 
    
    func dispatchGetService()
    {
        var soapMessage : String = "<?xml version='1.0' encoding='utf-8'?>"
        soapMessage += "<soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'>"
        soapMessage += "<soap:Body><UserProfilService xmlns='http://tempuri.org/'>"
        soapMessage += "<AdminEmail>\(GlobalData.adminUserName.rawValue)</AdminEmail>"
        soapMessage += "<AdminPass>\(GlobalData.adminPass.rawValue)</AdminPass>"
        soapMessage += "<UserId>35</UserId>"
        //soapMessage += "<UserId>\(UserPrefence.getUserId())</UserId>"
        soapMessage += "</UserProfilService>"
        soapMessage += "</soap:Body></soap:Envelope>"
        
        let serviceUrl : String = HttpAdress.staticLink + HttpAdress.userProfileServicelink
        print(soapMessage)
        print(serviceUrl)
        
        connection.cineDBMakePostConnection(soapMessage: soapMessage, serviceUrl: serviceUrl)
    }
   
    
    func getJson(xmlData: XMLIndexer) {
        var userProfileResponse : UserProfileServiceResponseModel = UserProfileServiceResponseModel()
        
        let path = xmlData["soap:Envelope"]
        let path2 = path["soap:Body"]
        let path3 = path2["UserProfilServiceResponse"]
        let result = path3["UserProfilServiceResult"]
        let subProfileVM = result["SubProfilVM"]["SubProfilVM"]
        
        print(result)
        print(subProfileVM)
        
        for subProfile in result["SubProfilVM"]["SubProfilVM"].all {
        
            var subProfileModel : SubProfileModel = SubProfileModel()
            print(subProfile)
            
            if subProfile["Id"].element?.text != nil{
                guard let user_id = subProfile["Id"].element?.text else {
                    print("adwerd adwerd_id Error...")
                    return
                }
                subProfileModel._id = user_id
            }
            
            if subProfile["UserName"].element?.text != nil{
                guard let user_name = subProfile["UserName"].element?.text else {
                    print("adwerd adwerd_id Error...")
                    return
                }
                subProfileModel.userName = user_name
            }
            
            if subProfile["Count"].element?.text != nil{
                guard let count = subProfile["Count"].element?.text else {
                    print("adwerd adwerd_id Error...")
                    return
                }
                subProfileModel.count = count
            }
            
            if subProfile["Error"].element?.text != nil{
                guard let error = subProfile["Error"].element?.text else {
                    print("adwerd error Error...")
                    return
                }
                subProfileModel.error = error
            }
            
            
            userProfileResponse.subProfiles.append(subProfileModel)
           

        
        }
        
        
        
        if result["Coins"].element?.text != nil{
            guard let coins = result["Coins"].element?.text else {
                print("registerResponseData _id Error...")
                return
            }
           userProfileResponse.coins = coins
        }
        
        if result["Email"].element?.text != nil{
            guard let Email = result["Email"].element?.text else {
                print("registerResponseData Email Error...")
                return
            }
            userProfileResponse.email = Email
        }
        
        if result["UserName"].element?.text != nil{
            guard let Name = result["UserName"].element?.text else {
                print("registerResponseData Name Error...")
                return
            }
            userProfileResponse.userName = Name
        }
        
        if result["RefNo"].element?.text != nil{
            guard let RefNo = result["RefNo"].element?.text else {
                print("registerResponseData RefNo Error...")
                return
            }
            userProfileResponse.refNo = RefNo
        }
        
        
        
        if result["_id"].element?.text != nil{
            guard let id = result["_id"].element?.text else {
                print("registerResponseData TotalCoins Error...")
                return
            }
            userProfileResponse._id = id
        }
        
        if result["Message"].element?.text != nil{
            guard let Message = result["Message"].element?.text else {
                print("registerResponseData Message Error...")
                return
            }
            userProfileResponse.message = Message
        }
        if result["Error"].element?.text != nil{
            guard let Error = result["Error"].element?.text else {
                print("registerResponseData Message Error...")
                return
            }
            userProfileResponse.error = Error
        }
            if  self.serviceDelegate != nil {
                self.serviceDelegate?.getUserProfileService(response: userProfileResponse)
            }
       
        
       
    }
    
    func getError(errMessage: String) {
        if  self.serviceDelegate != nil {
            self.serviceDelegate?.getError()
        }
    }
    init(){
        
        self.connection.delegate = self
        
    }
    
}

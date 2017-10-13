//
//  LoginService.swift
//  App To Rich
//
//  Created by Baran on 7.10.2017.
//  Copyright © 2017 bilal. All rights reserved.
//

import Foundation
import SWXMLHash

class LoginService : ConnectionDelegate
{
   	
    let connection = PostConnection()
    var serviceDelegate : LoginServiceDelegate?
    
    var userMail = ""
    var userPassword = ""
    
    func dispatchGetService(facebookId: String)
    {
        var soapMessage : String = "<?xml version='1.0' encoding='utf-8'?>"
        soapMessage += "<soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'>"
        soapMessage += "<soap:Body><LoginService xmlns='http://tempuri.org/'>"
        soapMessage += "<AdminEmail>\(GlobalData.adminUserName.rawValue)</AdminEmail>"
        soapMessage += "<AdminPass>\(GlobalData.adminPass.rawValue)</AdminPass>"
        soapMessage += "<FaceBookId>\(facebookId)</FaceBookId>"
        soapMessage += "</LoginService>"
        soapMessage += "</soap:Body></soap:Envelope>"
        
        let serviceUrl : String = HttpAdress.staticLink + HttpAdress.loginServiceLink
        connection.cineDBMakePostConnection(soapMessage: soapMessage, serviceUrl: serviceUrl)
    }
    
    func dispatchGetService(mail: String, password: String)
    {
        self.userPassword = password
        self.userMail =  mail
        
        var soapMessage : String = "<?xml version='1.0' encoding='utf-8'?>"
        soapMessage += "<soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'>"
        soapMessage += "<soap:Body><LoginService xmlns='http://tempuri.org/'>"
        soapMessage += "<AdminEmail>\(GlobalData.adminUserName.rawValue)</AdminEmail>"
        soapMessage += "<AdminPass>\(GlobalData.adminPass.rawValue)</AdminPass>"
        soapMessage += "<UserEmail>\(mail)</UserEmail>"
        soapMessage += "<UserPass>\(password)</UserPass>"
        soapMessage += "</LoginService>"
        soapMessage += "</soap:Body></soap:Envelope>"
        
        let serviceUrl : String = HttpAdress.staticLink + HttpAdress.loginServiceLink
        connection.cineDBMakePostConnection(soapMessage: soapMessage, serviceUrl: serviceUrl)
    }
    
    func getJson(xmlData: XMLIndexer) {
        var registerResponseData : RegisterServiceResponseModel = RegisterServiceResponseModel()
        
        let path = xmlData["soap:Envelope"]
        let path2 = path["soap:Body"]
        let path3 = path2["LoginServiceResponse"]
        let result = path3["LoginServiceResult"]
        print(result)
        
        
        
        if result["_id"].element?.text != nil{
            guard let _id = result["_id"].element?.text else {
                print("registerResponseData _id Error...")
                return
            }
            registerResponseData._id = _id
        }
        
        if result["Email"].element?.text != nil{
            guard let Email = result["Email"].element?.text else {
                print("registerResponseData Email Error...")
                return
            }
            registerResponseData.Email = Email
        }
        
        if result["Name"].element?.text != nil{
            guard let Name = result["Name"].element?.text else {
                print("registerResponseData Name Error...")
                return
            }
            registerResponseData.Name = Name
        }
        
        if result["RefNo"].element?.text != nil{
            guard let RefNo = result["RefNo"].element?.text else {
                print("registerResponseData RefNo Error...")
                return
            }
            registerResponseData.RefNo = RefNo
        }
        
        if result["ImagePath"].element?.text != nil{
            guard let ImagePath = result["ImagePath"].element?.text else {
                print("registerResponseData ImagePath Error...")
                return
            }
            registerResponseData.ImagePath = ImagePath
        }
        
        if result["TotalCoins"].element?.text != nil{
            guard let TotalCoins = result["TotalCoins"].element?.text else {
                print("registerResponseData TotalCoins Error...")
                return
            }
            registerResponseData.TotalCoins = TotalCoins
        }
        
        if result["Message"].element?.text != nil{
            guard let Message = result["Message"].element?.text else {
                print("registerResponseData Message Error...")
                return
            }
            registerResponseData.Message = Message
        }
        if result["Error"].element?.text != nil{
            guard let err = result["Error"].element?.text else {
                print("registerResponseData Message Error...")
                return
            }
            registerResponseData.Error = err
        }
        if registerResponseData.Error == "false" {
            UserPrefence.saveUserMail(mail: self.userMail )
            UserPrefence.saveUserPassword(password: self.userPassword)
            UserPrefence.saveUserLoginStatus(isLogin: true)
            UserPrefence.saveUserId(id: registerResponseData._id)
            if  self.serviceDelegate != nil {
                self.serviceDelegate?.getLoginService(response: registerResponseData)
            }
        }
        else {
            if  self.serviceDelegate != nil {
                self.serviceDelegate?.getError()
            }
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

//
//  RegisterService.swift
//  App To Rich
//
//  Created by Baran on 7.10.2017.
//  Copyright © 2017 bilal. All rights reserved.
//

import Foundation
import SWXMLHash

class RegisterService : ConnectionDelegate
{
   	
    let connection = PostConnection()
    var serviceDelegate : RegisterServiceDelegate?
    
    func dispatchGetService(model : RegisterServiceSendData)
    {
        var soapMessage : String = "<?xml version='1.0' encoding='utf-8'?>"
        soapMessage += "<soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'>"
        soapMessage += "<soap:Body><UserAddService xmlns='http://tempuri.org/'>"
        soapMessage += "<AdminEmail>\(GlobalData.adminUserName.rawValue)</AdminEmail>"
        soapMessage += "<AdminPass>\(GlobalData.adminPass.rawValue)</AdminPass>"
        soapMessage += "<UserEmail>\(model.UserEmail)</UserEmail>"
        soapMessage += "<UserPass>\(model.UserPass)</UserPass>"
        soapMessage += "<UserName>\(model.UserName)</UserName>"
        soapMessage += "<MacId>\(model.MacId)</MacId>"
        soapMessage += "<OneSignalId>\(model.OneSignalId)</OneSignalId>"
        soapMessage += "<FaceBookId>\(model.FaceBookId)</FaceBookId>"
        soapMessage += "<ReferenceNo>\(model.RefNo)</ReferenceNo>"
        soapMessage += "</UserAddService>"
        soapMessage += "</soap:Body></soap:Envelope>"
        
        
        print(soapMessage)
        let serviceUrl : String = HttpAdress.staticLink + HttpAdress.registerServiceLink
        connection.cineDBMakePostConnection(soapMessage: soapMessage, serviceUrl: serviceUrl)
    }
    
    func getJson(xmlData: XMLIndexer) {
        var registerResponseData : RegisterServiceResponseModel = RegisterServiceResponseModel()
        
        let path = xmlData["soap:Envelope"]
        let path2 = path["soap:Body"]
        let path3 = path2["UserAddServiceResponse"]
        let result = path3["UserAddServiceResult"]
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
            guard let Error = result["Error"].element?.text else {
                print("registerResponseData Message Error...")
                return
            }
            registerResponseData.Error = Error
        }
        if  self.serviceDelegate != nil {
                self.serviceDelegate?.getRegisterService(response: registerResponseData)
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

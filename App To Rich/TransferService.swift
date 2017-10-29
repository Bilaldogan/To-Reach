//
//  TransferService.swift
//  App To Rich
//
//  Created by bilal on 22/10/2017.
//  Copyright © 2017 bilal. All rights reserved.
//

import Foundation
import SWXMLHash

class TransferService : ConnectionDelegate
{
   	
    let connection = PostConnection()
    var serviceDelegate : TransferServiceDelegate?
    
    func dispatchGetService(model : TransferServiceSendData)
    {
        var soapMessage : String = "<?xml version='1.0' encoding='utf-8'?>"
        soapMessage += "<soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'>"
        soapMessage += "<soap:Body><UserMoneyService xmlns='http://tempuri.org/'>"
        soapMessage += "<AdminEmail>\(GlobalData.adminUserName.rawValue)</AdminEmail>"
        soapMessage += "<AdminPass>\(GlobalData.adminPass.rawValue)</AdminPass>"
        soapMessage += "<UserId>\(UserPrefence.getUserId())</UserId>"
        soapMessage += "<Iban>\(model.ibanNo)</Iban>"
        soapMessage += "<Gsm>\(model.gSM)</Gsm>"
        soapMessage += "<Price>\(model.amount)</Price>"
        soapMessage += "</UserMoneyService>"
        soapMessage += "</soap:Body></soap:Envelope>"
        
        
        print(soapMessage)
        let serviceUrl : String = HttpAdress.staticLink + HttpAdress.transferServiceLink
        connection.cineDBMakePostConnection(soapMessage: soapMessage, serviceUrl: serviceUrl)
    }
    
    func getJson(xmlData: XMLIndexer) {
        var registerResponseData : RegisterServiceResponseModel = RegisterServiceResponseModel()
        
        let path = xmlData["soap:Envelope"]
        let path2 = path["soap:Body"]
        let result = path2["UserMoneyServiceResponse"]
        print(result)
        
        
        var status = ""
        if result["UserMoneyServiceResult"].element?.text != nil{
            guard let stts = result["UserMoneyServiceResult"].element?.text else {
                print("registerResponseData _id Error...")
                return
            }
            status = stts
        }
        
        if  self.serviceDelegate != nil {
            self.serviceDelegate?.getTrasnferService(status: status)
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

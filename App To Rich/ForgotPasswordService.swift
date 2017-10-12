//
//  ForgotPasswordService.swift
//  App To Rich
//
//  Created by bilal on 12/10/17.
//  Copyright © 2017 bilal. All rights reserved.
//

import Foundation
import SWXMLHash

class ForgotPasswordService : ConnectionDelegate
{
   	
    let connection = PostConnection()
    var serviceDelegate : ForgotPasswordServiceDelegate?
    
    var userMail = ""
    var userPassword = ""
    
    func dispatchGetService(with email: String)
    {
        var soapMessage : String = "<?xml version='1.0' encoding='utf-8'?>"
        soapMessage += "<soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'>"
        soapMessage += "<soap:Body><ForgotPassService xmlns='http://tempuri.org/'>"
        soapMessage += "<AdminEmail>\(GlobalData.adminUserName.rawValue)</AdminEmail>"
        soapMessage += "<AdminPass>\(GlobalData.adminPass.rawValue)</AdminPass>"
        soapMessage += "<UserEmail>\(email)</UserEmail>"
        soapMessage += "</ForgotPassService>"
        soapMessage += "</soap:Body></soap:Envelope>"
        
        let serviceUrl : String = HttpAdress.staticLink + HttpAdress.forgotPassLink
        connection.cineDBMakePostConnection(soapMessage: soapMessage, serviceUrl: serviceUrl)
    }
    
    func getJson(xmlData: XMLIndexer) {
        
        
        let path = xmlData["soap:Envelope"]
        let path2 = path["soap:Body"]
        let path3 = path2["ForgotPassServiceResponse"]
        let result = path3["ForgotPassServiceResult"]
        print(result)
        
        var status = ""
        
        if result["error"].element?.text != nil{
            guard let sttus = result["error"].element?.text else {
                print("registerResponseData _id Error...")
                return
            }
            status = sttus
        }
        
        if  self.serviceDelegate != nil {
            self.serviceDelegate?.getForgorService(status: status)
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

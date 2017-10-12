
//
//  ClickAdwerdService.swift
//  App To Rich
//
//  Created by Baran on 12.10.2017.
//  Copyright © 2017 bilal. All rights reserved.
//

import Foundation
import SWXMLHash

class ClickAdwerdService : ConnectionDelegate
{
   	
    let connection = PostConnection()
    var serviceDelegate : ClickAdwerdServiceDelegate?
    
    
    func dispatchGetService(model : ClickAdwerdSendData)
    {
        var soapMessage : String = "<?xml version='1.0' encoding='utf-8'?>"
        soapMessage += "<soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'>"
        soapMessage += "<soap:Body><AddAppService xmlns='http://tempuri.org/'>"
        soapMessage += "<AdminEmail>\(GlobalData.adminUserName.rawValue)</AdminEmail>"
        soapMessage += "<AdminPass>\(GlobalData.adminPass.rawValue)</AdminPass>"
        soapMessage += "<UserId>\(model.UserId)</UserId>"
        soapMessage += "<AppId>\(model.AppId)</AppId>"
        soapMessage += "</AddAppService>"
        soapMessage += "</soap:Body></soap:Envelope>"
        
        let serviceUrl : String = HttpAdress.staticLink + HttpAdress.clickAdwerdLink
        print(soapMessage)
        print(serviceUrl)
        
        connection.cineDBMakePostConnection(soapMessage: soapMessage, serviceUrl: serviceUrl)
    }
    
    func getJson(xmlData: XMLIndexer) {
        var clickAdwerdResponseData : ClickAdwerdResponseModel = ClickAdwerdResponseModel()
        
        let path = xmlData["soap:Envelope"]
        let path2 = path["soap:Body"]
        let path3 = path2["AddAppServiceResponse"]
        let result = path3["AddAppServiceResult"]
        
        
        if result["Message"].element?.text != nil{
            guard let Message = result["Message"].element?.text else {
                print("adwerd Message Error...")
                return
            }
            clickAdwerdResponseData.Message = Message
        }
        
        if  self.serviceDelegate != nil {
            self.serviceDelegate?.getUserProfileService(response: clickAdwerdResponseData)
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


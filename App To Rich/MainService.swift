//
//  MainService.swift
//  App To Rich
//
//  Created by Baran on 7.10.2017.
//  Copyright © 2017 bilal. All rights reserved.
//

import Foundation
import SWXMLHash

class MainService : ConnectionDelegate
{
   	
    let connection = PostConnection()
    var serviceDelegate : MainServiceDelegate?
    
    
    func dispatchGetService(model : MainServiceSendData)
    {
        var soapMessage : String = "<?xml version='1.0' encoding='utf-8'?>"
        soapMessage += "<soap:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap='http://schemas.xmlsoap.org/soap/envelope/'>"
        soapMessage += "<soap:Body><AppListService xmlns='http://tempuri.org/'>"
        soapMessage += "<AdminEmail>\(GlobalData.adminUserName.rawValue)</AdminEmail>"
        soapMessage += "<AdminPass>\(GlobalData.adminPass.rawValue)</AdminPass>"
        soapMessage += "<PageNumber>\(model.PageNumber)</PageNumber>"
        soapMessage += "<UserId>\(model.UserId)</UserId>"
        soapMessage += "</AppListService>"
        soapMessage += "</soap:Body></soap:Envelope>"
        
        let serviceUrl : String = HttpAdress.staticLink + HttpAdress.mainServiceLink
        print(soapMessage)
        print(serviceUrl)
        
        connection.cineDBMakePostConnection(soapMessage: soapMessage, serviceUrl: serviceUrl)
    }
    
    func getJson(xmlData: XMLIndexer) {
        var mainResponseData : MainServiceResponseModel = MainServiceResponseModel()
        
        let path = xmlData["soap:Envelope"]
        let path2 = path["soap:Body"]
        let path3 = path2["AppListServiceResponse"]
        let path4 = path3["AppListServiceResult"]
        let result = path4["AppList"]
        
        print(result)
        
        for adwerd in result["AppListVM"].all {
            var mainServiceList : MainServiceResponseList = MainServiceResponseList()
            
            if adwerd["_id"].element?.text != nil{
                guard let adwerd_id = adwerd["_id"].element?.text else {
                    print("adwerd adwerd_id Error...")
                    return
                }
                mainServiceList.addwerd_id = adwerd_id
            }
            
            if adwerd["ImagePath"].element?.text != nil{
                guard let ImagePath = adwerd["ImagePath"].element?.text else {
                    print("adwerd ImagePath Error...")
                    return
                }
                mainServiceList.ImagePath = ImagePath
            }
            
            if adwerd["AppName"].element?.text != nil{
                guard let AppName = adwerd["AppName"].element?.text else {
                    print("adwerd AppName Error...")
                    return
                }
                mainServiceList.AppName = AppName
            }
            
            if adwerd["AppUrl"].element?.text != nil{
                guard let AppUrl = adwerd["AppUrl"].element?.text else {
                    print("adwerd AppUrl Error...")
                    return
                }
                mainServiceList.AppUrl = AppUrl
            }
            
            if adwerd["Coins"].element?.text != nil{
                guard let Coins = adwerd["Coins"].element?.text else {
                    print("adwerd Coins Error...")
                    return
                }
                mainServiceList.Coins = Coins
            }
            
            mainResponseData.adwerdList.append(mainServiceList)
        }
        
        if  self.serviceDelegate != nil {
            self.serviceDelegate?.getMainService(response: mainResponseData)
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

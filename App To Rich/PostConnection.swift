//
//  PostConnection.swift
//  soapServiceConnection
//
//  Created by Baran on 3.05.2017.
//  Copyright © 2017 Baran. All rights reserved.
//

import Foundation
import SWXMLHash


class PostConnection
{
    
    var delegate : ConnectionDelegate?
    
    func cineDBMakePostConnection(soapMessage : String, serviceUrl: String)
    {
        let staticSoapMessage : String = soapMessage
        let urlString : String = serviceUrl
        
        let url : NSURL = NSURL(string: urlString)!
        let theRequest = NSMutableURLRequest(url: url as URL)
        let msgLenght = staticSoapMessage.characters.count
        theRequest.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        theRequest.addValue(String(msgLenght), forHTTPHeaderField: "Content-Length")
        theRequest.httpMethod = "POST"
        theRequest.httpBody = staticSoapMessage.data(using: String.Encoding.utf8, allowLossyConversion: false) // or false
        
        
        URLSession.shared.dataTask(with: theRequest as URLRequest) { (data, response, error) in
            print("Started Connection..")
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                self.delegate?.getError(errMessage: "servisResponse")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
                self.delegate?.getError(errMessage: "servisResponse")
                return
            }
            
            let newXML = SWXMLHash.parse(data)
                if  self.delegate != nil {
                    DispatchQueue.main.async {
                        self.delegate?.getJson(xmlData: newXML)
                    }
                }
            
            }.resume()
    }
}

//
//  ServicesDelegate.swift
//  App To Rich
//
//  Created by Baran on 7.10.2017.
//  Copyright © 2017 bilal. All rights reserved.
//

import Foundation


protocol RegisterServiceDelegate {
    func getRegisterService(response : RegisterServiceResponseModel)
    func getError()
}

protocol LoginServiceDelegate {
    
    func getLoginService(response : RegisterServiceResponseModel)
    func getError()
}

protocol MainServiceDelegate {
    
    func getMainService(response : MainServiceResponseModel)
    func getError()
    
}

protocol UserProfileServiceDelegate {
    func getUserProfileService(response : UserProfileServiceResponseModel)
    func getError()
}

protocol ClickAdwerdServiceDelegate {
    func getUserProfileService(response : ClickAdwerdResponseModel)
    func getError()
}

protocol ForgotPasswordServiceDelegate {
    func getForgorService(status : String)
    func getError()
}

//
//  ResponseModel.swift
//  App To Rich
//
//  Created by Baran on 7.10.2017.
//  Copyright © 2017 bilal. All rights reserved.
//

import Foundation

struct RegisterServiceResponseModel {
    
    var _id : String = ""
    var Email : String = ""
    var Name : String = ""
    var TotalCoins : String = ""
    var RefNo : String = ""
    var ImagePath : String = ""
    var Message : String = ""
    var Error : String = "true"
}

struct UserProfileServiceResponseModel {
    var subProfiles : [SubProfileModel] = []
    var coins : String = ""
    var refNo : String = ""
    var userName : String = ""
    var email : String = ""
    var _id : String = ""
    var message : String = ""

    
}
struct SubProfileModel {
    var _id : String = ""
    var userName : String = ""
    var count : String = ""
}
struct MainServiceResponseModel {
    
    var adwerdList = [MainServiceResponseList]()
}

struct MainServiceResponseList {
   
    var ImagePath : String = ""
    var AppName : String = ""
    var AppUrl : String = ""
    var Coins : String = ""
    var addwerd_id : String = ""
}


struct ClickAdwerdResponseModel {
    
    var Message : String = ""
    var Error : String = ""
}

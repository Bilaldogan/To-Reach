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
    
}

struct UserProfileServiceResponseModel {
    var subProfiles : [SubProfileModel] = []
    var coins : Double = 0
    var refNo : String = ""
    var userName : String = ""
    var email : String = ""
    var _id : Int = 0
    var message : String = ""
}

struct SubProfileModel {
    var _id : Int = 0
    var userName : String = ""
    var count : Int = 0
}


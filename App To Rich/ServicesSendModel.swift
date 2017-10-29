//
//  ServicesSendModel.swift
//  App To Rich
//
//  Created by Baran on 7.10.2017.
//  Copyright © 2017 bilal. All rights reserved.
//

import Foundation


struct RegisterServiceSendData {
    
    var UserEmail : String = ""
    var UserPass : String = ""
    var UserName : String = ""
    var MacId : String = ""
    var OneSignalId : String = ""
    var FaceBookId : String = ""
    var RefNo : String = ""
}

struct MainServiceSendData {
    
    var PageNumber : String = ""
    var UserId : String = ""
    
}


struct ClickAdwerdSendData {
    
    var UserId : String = ""
    var AppId : String = ""
}

struct TransferServiceSendData {
    var amount = ""
    var ibanNo = ""
    var gSM = ""
}

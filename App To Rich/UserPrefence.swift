//
//  UserPrefence.swift
//  App To Rich
//
//  Created by bilal on 07/10/17.
//  Copyright © 2017 bilal. All rights reserved.
//

import Foundation

class UserPrefence {
    static let userDefaults = UserDefaults.standard
    
    static func saveUserMail(mail : String) {
        self.userDefaults.setValue(mail, forKey: mail)
    }
    static func getUserMail() -> String {
        if let mail = userDefaults.value(forKeyPath: mail) as? String {
            return mail
        }
        return ""
    }
    static func removeUserMail(){
        UserDefaults.standard.removeObject(forKey: mail)
    }
    
    static func saveUserLoginStatus(isLogin : Bool) {
        self.userDefaults.setValue(isLogin, forKey: isLoginned)
    }
    static func isUserLoginned() -> Bool {
        if let status = userDefaults.value(forKeyPath: isLoginned) as? Bool {
            return status
        }
        return false
    }
    
    static func saveUserId(id: String) {
        self.userDefaults.set(id, forKey: userID)
    }
    static func getUserId() -> String {
        if let id = userDefaults.value(forKeyPath: userID) as? String {
            return id
        }
        return ""
    }
    static func removeUserId(){
        UserDefaults.standard.removeObject(forKey: userID)
    }
    
    static func saveOneSignalId(id: String) {
        self.userDefaults.set(id, forKey: oneSignalUserId)
    }
    static func getOneSignalId() -> String {
        if let id = userDefaults.value(forKeyPath: oneSignalUserId) as? String {
            return id
        }
        return ""
    }
    static func removeoneSignalUserId(){
        UserDefaults.standard.removeObject(forKey: oneSignalUserId)
    }
    static func saveUserCoins(coins: String) {
        self.userDefaults.set(coins, forKey: userCoins)
    }
    static func getUserCoins() -> Int {
        if let coins = userDefaults.value(forKeyPath: userCoins) as? Int {
            return coins
        }
        return 0
    }
    
   
    
    private static let mail = "userMail"
    private static let password = "userPassword"
    private static let isLoginned = "isLoginned"
    private static let userID = "userID"
    private static let oneSignalUserId = "oneSignalUserId"
    private static let userCoins = "userCoins"
}

//
//  RegexClass.swift
//  CineBul
//
//  Created by Baran on 4.05.2017.
//  Copyright © 2017 CaWeb. All rights reserved.
//

import Foundation
import UIKit

struct RegexClass {
   
    static func validatePhone(value: String) -> Bool {
        let PHONE_REGEX = "^\\d{11}"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    
    static func validateButunNumaralarSifirOlarmaz(textField : AnimatedTextInput) -> Bool{
        textField.resignFirstResponder();
        var numberCounter = 0
        
        for index in textField.text!.characters.indices {
            //print("asd:",phoneNumberTextFields.text[index])
            if textField.text![index] == "0" {
                numberCounter += 1
            }
        }
        
        if numberCounter == 11
        {
            return false
        }
        else{
            return true
        }
    }
    static func isValidEmail(testStr:String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
}

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = "."
        formatter.numberStyle = .decimal
        return formatter
    }()
}

extension Integer {
    var formattedWithSeparator: String {
        return Formatter.withSeparator.string(for: self) ?? ""
    }
}


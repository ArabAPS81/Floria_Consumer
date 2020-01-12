//
//  Extension.swift
//  floriaConsumer
//
//  Created by Mariam Elenna on 12/28/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import Foundation
extension String{
    
    var trimmed : String{
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    enum ValidityType {
        case name
        case email
        case phone
        case password
    }
    
    enum RegularExpressions : String{
        case name = "[a-zA-Z ]{3,50}"
        case email = "[A-Z0-9a-z._%+_]+@[A-Za-z0-9.-]+\\.[A-Za-z.]{2,64}"
        case phone = "^(01(0|1|2|5)[0-9]{8})"
        case password = "^(?=.{8,})"
    }
    
    func isValid(_ validityType: ValidityType) -> Bool {
        let format = "SELF MATCHES %@"
        var regEx = ""
        
        switch validityType {
        case .name:
            regEx = RegularExpressions.name.rawValue
        case .email:
            regEx = RegularExpressions.email.rawValue
        case .phone:
            regEx = RegularExpressions.phone.rawValue
        case .password:
            regEx = RegularExpressions.password.rawValue
        }
        return NSPredicate(format: format, regEx).evaluate(with: self)
    }
    
}

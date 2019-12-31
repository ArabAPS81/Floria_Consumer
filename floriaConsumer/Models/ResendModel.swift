//
//  ResendModel.swift
//  floriaConsumer
//
//  Created by Mariam on 12/30/2562 BE.
//  Copyright © 2562 BE Obida. All rights reserved.
//

import Foundation

struct ResendModel : Codable {
    
    let httpCode : Int?
    let message : String?
    
    enum CodingKeys: String, CodingKey {
        case httpCode = "http_code"
        case message = "message"
    }
}


struct ForgetPassModel : Codable {
    let data : Data?
    let httpCode : Int?
    let message : String?
    
    enum CodingKeys: String, CodingKey {
        case data
        case httpCode = "http_code"
        case message = "message"
    }
    
    struct Data : Codable {

        let mobile : String
        enum CodingKeys: String, CodingKey {
            case mobile = "mobile"
        }

    }
}


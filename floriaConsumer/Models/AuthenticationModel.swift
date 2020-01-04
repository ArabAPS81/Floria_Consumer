//
//  AuthenticationModel.swift
//  floriaConsumer
//
//  Created by Mariam Elenna on 12/29/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import Foundation

struct AuthenticationModel: Codable {
    
    let user : User?
    let httpCode : Int?
    let message : String?
    
    enum CodingKeys: String, CodingKey {
        case user = "data"
        case httpCode = "http_code"
        case message = "message"
    }
    
    struct User : Codable {
        
        let accessToken : String?
        let createdAt : String?
        let email : String?
        let expiresAt : String?
        let id : Int?
        let mobile : String?
        let name : String?
        let tokenType : String?
        let verified : Bool?
        
        enum CodingKeys: String, CodingKey {
            case accessToken = "access_token"
            case createdAt = "created_at"
            case email = "email"
            case expiresAt = "expires_at"
            case id = "id"
            case mobile = "mobile"
            case name = "name"
            case tokenType = "token_type"
            case verified = "verified"
        }
    }
}

struct RegisterErrorModel : Codable {

    let error : Error?
    let httpCode : Int?


    enum CodingKeys: String, CodingKey {
        case error
        case httpCode = "http_code"
    }
    
    struct Error : Codable {

        let message : Message?
        
        
        struct Message : Codable {

            let email : [String]?
            let mobile : [String]?

            enum CodingKeys: String, CodingKey {
                case email = "email"
                case mobile = "mobile"
            }

        }

    }

}

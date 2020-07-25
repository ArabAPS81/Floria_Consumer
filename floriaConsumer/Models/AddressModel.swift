//
//  AddressModel.swift
//  floriaConsumer
//
//  Created by arabpas on 12/17/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import Foundation

struct AddressModel : Codable {

    let addresses : [Address]?
    let httpCode : Int?


    enum CodingKeys: String, CodingKey {
        case addresses = "data"
        case httpCode = "http_code"
    }
    
    struct Address : Codable {

        let anotherMobile : String?
        let apartmentNumber : String?
        let buildingNumber : String?
        let district : District?
        let id : Int
        let mobile : String?
        let name : String?
        let notes : String?
        let postalCode : String?
        let streetName : String?
       // let userId : String?
        let contactName: String?

        enum CodingKeys: String, CodingKey {
            case anotherMobile = "another_mobile"
            case apartmentNumber = "apartment_number"
            case buildingNumber = "building_number"
            case district
            case id = "id"
            case mobile = "mobile"
            case name = "name"
            case notes = "notes"
            case postalCode = "postal_code"
            case streetName = "street_name"
           // case userId = "user_id"
            case contactName = "contact_name"
        }
    }
    
    struct District : Codable {

        let id : Int?
        let name : String?
        enum CodingKeys: String, CodingKey {
            case id = "id"
            case name = "name"
        }
    }
}


struct AddAddressResponseModel : Codable {

    let error : Errors?
    let httpCode : Int?
    let address: AddressModel.Address?


    enum CodingKeys: String, CodingKey {
        case error
        case httpCode = "http_code"
        case address = "data"
    }
    
    struct Errors : Codable {

        let message : Message?

        enum CodingKeys: String, CodingKey {
            case message
        }
        
        struct Message : Codable {

            let mobile : [String]?
            let streetName : [String]?

            enum CodingKeys: String, CodingKey {
                case mobile = "mobile"
                case streetName = "street_name"
            }
        }
    }
}

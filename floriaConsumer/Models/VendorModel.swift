//
//  VendorsModel.swift
//  floriaConsumer
//
//  Created by arabpas on 12/11/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import Foundation

struct VendorsModel: Codable {

    let vendors : [Vendor]!
    let httpCode : Int?

    enum CodingKeys: String, CodingKey {
        case vendors = "data"
        case httpCode = "http_code"
    }
    
    struct Vendor: Codable {

        let address : String?
        let decorationTypes : [DecorationType]?
        let district : District?
        let email : String?
        let facebookUrl : String?
        let id : Int?
        let image : String?
        let lat : Float?
        let lng : Float?
        let mobile : String?
        let name : String?
        let services : [Service]?
        let isFavorited: Bool
        let rate: Int

        enum CodingKeys: String, CodingKey {
            case address = "address"
            case decorationTypes = "decorationTypes"
            case district
            case email = "email"
            case facebookUrl = "facebook_url"
            case id = "id"
            case image = "image"
            case lat = "lat"
            case lng = "lng"
            case mobile = "mobile"
            case name = "name"
            case services = "services"
            case isFavorited
            case rate
        }
    }
    
    struct Service : Codable {

        let id : Int?
        let image : String?
        let name : String?

        enum CodingKeys: String, CodingKey {
            case id = "id"
            case image = "image"
            case name = "name"
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
    
    struct DecorationType : Codable {

        let descriptionField : String?
        let id : Int?
        let image : String?
        let name : String?
        let price : Int?

        enum CodingKeys: String, CodingKey {
            case descriptionField = "description"
            case id = "id"
            case image = "image"
            case name = "name"
            case price = "price"
        }
    }


}



struct VendorDetailsModel : Codable {

    let data : VendorsModel.Vendor?
    let httpCode : Int?
    let message : String?


    enum CodingKeys: String, CodingKey {
        case data
        case httpCode = "http_code"
        case message = "message"
    }
    
    


}

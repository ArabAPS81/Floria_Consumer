//
//  ProductsModel.swift
//  floriaConsumer
//
//  Created by arabpas on 12/11/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import Foundation

struct ProductsModel : Codable {

    let products : [Product]?
    let httpCode : Int?

    enum CodingKeys: String, CodingKey {
        case products = "data"
        case httpCode = "http_code"
    }
    struct Product : Codable {

        let descriptionField : String?
        let id : Int?
        let image : String?
        let name : String?
        let price : String?
        let provider : Provider?
        let service : Service?
        let isFavorited: Bool
        let rate: Int


        enum CodingKeys: String, CodingKey {
            case descriptionField = "description"
            case id = "id"
            case image = "image"
            case name = "name"
            case price = "price"
            case provider
            case service
            case isFavorited
            case rate
        }
        
        struct Provider : Codable {

            let address : String?
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
            

            enum CodingKeys: String, CodingKey {
                case address = "address"
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


    }

}

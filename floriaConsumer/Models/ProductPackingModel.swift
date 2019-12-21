//
//  ProductPackingModel.swift
//  floriaConsumer
//
//  Created by arabpas on 12/19/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import Foundation

struct ProductPackingModel : Codable {

    let packings : [ProductPacking]?
    let httpCode : Int?
    
    enum CodingKeys: String, CodingKey {
        case packings = "data"
        case httpCode = "http_code"
    }
    
    struct ProductPacking : Codable {

        let descriptionField : String?
        let id : Int?
        let image : String?
        let name : String?
        let packingType : PackingType?
        let price : Double?


        enum CodingKeys: String, CodingKey {
            case descriptionField = "description"
            case id = "id"
            case image = "image"
            case name = "name"
            case packingType
            case price = "price"
        }
        
        struct PackingType : Codable {

            let id : Int?
            let name : String?

            enum CodingKeys: String, CodingKey {
                case id = "id"
                case name = "name"
            }
        }
        
    }
}

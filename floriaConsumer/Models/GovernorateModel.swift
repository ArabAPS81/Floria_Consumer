//
//  GovernorateModel.swift
//  floriaConsumer
//
//  Created by arabpas on 1/5/20.
//  Copyright © 2020 Obida. All rights reserved.
//

import Foundation

struct GovernorateModel: Codable {

    let governorates : [Governorate]?
    let httpCode : Int?

    enum CodingKeys: String, CodingKey {
        case governorates = "data"
        case httpCode = "http_code"
    }
    
    struct Governorate : Codable {

        let districts : [District]?
        let id : Int?
        let name : String?

        enum CodingKeys: String, CodingKey {
            case districts = "districts"
            case id = "id"
            case name = "name"
        }
        
        struct District : Codable {

            var id : Int?
            var name : String?

            enum CodingKeys: String, CodingKey {
                case id = "id"
                case name = "name"
            }
        }
    }


}

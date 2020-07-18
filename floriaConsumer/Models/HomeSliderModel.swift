//
//  HomeSliderModel.swift
//  floriaConsumer
//
//  Created by arabpas on 1/18/20.
//  Copyright © 2020 Obida. All rights reserved.
//

import Foundation

struct HomeSliderModel : Codable {

    let sliders : [Slider]?
    let httpCode : Int?


    enum CodingKeys: String, CodingKey {
        case sliders = "data"
        case httpCode = "http_code"
    }
    
    struct Slider: Codable {

        let content : String?
        let id : Int?
        let image : String?
        let modelId : String?
        let modelType : String?
        let title : String?

        enum CodingKeys: String, CodingKey {
            case content = "content"
            case id = "id"
            case image = "image"
            case modelId = "model_id"
            case modelType = "model_type"
            case title = "title"
        }
    }


}

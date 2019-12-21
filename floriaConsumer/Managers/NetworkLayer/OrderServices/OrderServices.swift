//
//  OrderServices.swift
//  floriaConsumer
//
//  Created by arabpas on 12/21/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import Foundation


class SubmittOrderQueryModel: Codable {
    
    static let submittOrderQueryModel = SubmittOrderQueryModel.init()
    
    var products: [OrderProducts] = []
    var packings: [OrderPackings] = []
    var shiping: Int?
    var payment_type_id: Int?
    var address_id: Int?
    var service_id: Int?
    struct OrderProducts: Codable {
        var id: Int
        var quantity: Int
        var price: Double
    }
    struct OrderPackings: Codable {
        var id: Int
        var quantity: Int
        var price: Double
        var packingTypeId: Int
        enum CodingKeys: String, CodingKey {
            case id
            case quantity
            case price
            case packingTypeId = "packing_type_id"
        }
        enum PackingTypeId: Int,Codable {
            case qw = 1,fe,gt
        }
    }
}


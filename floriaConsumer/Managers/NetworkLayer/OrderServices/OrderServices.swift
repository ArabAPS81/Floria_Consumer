//
//  OrderServices.swift
//  floriaConsumer
//
//  Created by arabpas on 12/21/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import Foundation
import Alamofire


class SubmittOrderQueryModel: Codable {
    
    static var submittOrderQueryModel = SubmittOrderQueryModel.init()
    
    var products: [OrderProducts] = []
    var packings: [OrderPackings] = []
    var shipping: Int?
    var paymentTypeId: Int?
    var addressId: Int?
    var serviceId: Int?
    var requiredAt : String?
    var providerId: Int?
    var carTypeId: Int?
    var colorId: Int?
    var decorationTypeId: Int?
    
    enum CodingKeys: String, CodingKey {
        case products
        case packings
        case shipping
        case paymentTypeId = "payment_type_id"
        case addressId = "address_id"
        case serviceId = "service_id"
        case providerId = "provider_id"
        case requiredAt = "required_at"
        case carTypeId = "car_type_id"
        case colorId = "color_id"
        case decorationTypeId = "decoration_type_id"
    }
    
    
    
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

class OrderServices {
    
    weak var delegate: WebServiceDelegate?
    
    init(delegate: WebServiceDelegate) {
        self.delegate = delegate
    }
    
    func getOrderSummary(order: SubmittOrderQueryModel) {
        
        let baseUrl = (NetworkConstants.baseUrl + "orders/summary")
        guard let url = (baseUrl).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        var params: [String:Any] = [:]
        do {
        let jsonData = try JSONEncoder().encode(order)
            params = try JSONSerialization.jsonObject(with: jsonData, options:[]) as! [String : Any]
        } catch {
            print(error.localizedDescription)
        }
        let headers = WebServiceConfigure.getHeadersForAuthenticatedState()
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseData { (response) in
            switch response.result {
            case .success(let value):
                JSONResponseDecoder.decodeFrom(value, returningModelType: OrderSummaryResponceModel.self) { (result, error) in
                    if let result = result {
                        self.delegate?.didRecieveData(data: result)
                    }
                }
            case .failure(let error):
                self.delegate?.didFailToReceiveDataWithError(error: error)
            }
        }
    }
    
    func submitOrder(order: SubmittOrderQueryModel) {
        
        let baseUrl = (NetworkConstants.baseUrl + "orders")
        guard let url = (baseUrl).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        var params: [String:Any] = [:]
        do {
        let jsonData = try JSONEncoder().encode(order)
            params = try JSONSerialization.jsonObject(with: jsonData, options:[]) as! [String : Any]
        } catch {
            print(error.localizedDescription)
        }
        let headers = WebServiceConfigure.getHeadersForAuthenticatedState()
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseData { (response) in
            switch response.result {
            case .success(let value):
                JSONResponseDecoder.decodeFrom(value, returningModelType: OrderSubmittResponseModel.self) { (result, error) in
                    if let result = result {
                        self.delegate?.didRecieveData(data: result)
                    }
                }
            case .failure(let error):
                self.delegate?.didFailToReceiveDataWithError(error: error)
            }
        }
    }
}

struct OrderSummaryResponceModel : Codable {

    let summary : Summary?
    let httpCode : Int?
    let message : String?


    enum CodingKeys: String, CodingKey {
        case summary = "data"
        case httpCode = "http_code"
        case message = "message"
    }
    
    struct Summary : Codable {

        let delivery : Int?
        let subtotal : Int?
        let total : Int?
        let totalTax : Int?

        enum CodingKeys: String, CodingKey {
            case delivery = "delivery"
            case subtotal = "subtotal"
            case total = "total"
            case totalTax = "total_tax"
        }
    }
}


struct OrderSubmittResponseModel : Codable {

    let data : Data?
    let httpCode : Int?
    let message : String?

    enum CodingKeys: String, CodingKey {
        case data
        case httpCode = "http_code"
        case message = "message"
    }
    struct Data : Codable {

        let id : Int?
        enum CodingKeys: String, CodingKey {
            case id = "id"
        }
    }
}

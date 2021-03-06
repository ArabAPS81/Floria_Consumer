//
//  OrderServices.swift
//  floriaConsumer
//
//  Created by arabpas on 12/21/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import Foundation
import Alamofire

var orderRequest = SubmittOrderQueryModel.submittOrderQueryModel

class SubmittOrderQueryModel: Codable {
    
    static var submittOrderQueryModel = SubmittOrderQueryModel.init()
    
    var products: [OrderProducts] = []
    var packings: [OrderPackings] = []
    var extras: [OrderPackings] = []
    var shipping: Int?
    var paymentTypeId: Int?
    var addressId: Int?
    var serviceId: Int?
    var requiredAt : String?
    var providerId: Int?
    var carTypeId: Int?
    var colorId: Int?
    var decorationTypeId: Int?
    var potSizeId: Int?
    var numOfPots: Int?
    var code: String?
    var notes: String?
    
    enum CodingKeys: String, CodingKey {
        case products
        case packings
        case extras
        case shipping
        case code,notes
        case paymentTypeId = "payment_type_id"
        case addressId = "address_id"
        case serviceId = "service_id"
        case providerId = "provider_id"
        case requiredAt = "required_at"
        case carTypeId = "car_type_id"
        case colorId = "color_id"
        case decorationTypeId = "decoration_type_id"
        case potSizeId = "pot_size_id"
        case numOfPots = "number_of_pots"
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
    
    init(delegate: WebServiceDelegate?) {
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
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                JSONResponseDecoder.decodeFrom(response.data!, returningModelType: OrderSummaryResponceModel.self) { (result, error) in
                    if let result = result {
                        self.delegate?.didRecieveData(data: result)
                    }else {
                        self.delegate?.didFailToReceiveDataWithError(error: error!)
                    }
                }
            case .failure(let error):
                self.delegate?.didFailToReceiveDataWithError(error: error)
            }
        }
    }
    
    func cancelOrder(merchantRefNum: Int) {
        let url = (NetworkConstants.baseUrl + "fawry/cancel")
        let params: [String:Any] = ["merchantRefNum": merchantRefNum]
        let headers = WebServiceConfigure.getHeadersForAuthenticatedState()
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseData { (response) in
            switch response.result {
            case .success(let value):
                JSONResponseDecoder.decodeFrom(value, returningModelType: ComplainModel.self) { (result, error) in
                    if let result = result {
                        self.delegate?.didRecieveData(data: result)
                    }else {
                        self.delegate?.didFailToReceiveDataWithError(error: error!)
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
                    }else {
                        self.delegate?.didFailToReceiveDataWithError(error: error!)
                    }
                }
            case .failure(let error):
                self.delegate?.didFailToReceiveDataWithError(error: error)
            }
        }
    }
    
    func submitOrderSuccess(orderId: Int) {
        
        let baseUrl = (NetworkConstants.baseUrlV2 + "fawry/success")
        guard let url = (baseUrl).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        let params: [String:Any] = ["order_id":orderId]
        let headers = WebServiceConfigure.getHeadersForAuthenticatedState()
        
        ApiConnection.request(.post, url: url,parameters:params, headers:headers, model: PaymentResponse.self, completion: { (result) in
            self.delegate?.didRecieveData(data: result)
        }) { (error) in
            self.delegate?.didFailToReceiveDataWithError(error: error)
        }
    }
    
    func submitOrderFailure(orderId: Int) {
        
        let baseUrl = (NetworkConstants.baseUrlV2 + "fawry/success")
        guard let url = (baseUrl).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        let params: [String:Any] = ["order_id":orderId]
        let headers = WebServiceConfigure.getHeadersForAuthenticatedState()
        
        ApiConnection.request(.post, url: url,parameters:params, headers:headers, model: PaymentResponse.self, completion: { (result) in
            self.delegate?.didRecieveData(data: result)
        }) { (error) in
            self.delegate?.didFailToReceiveDataWithError(error: error)
        }
    }
}

struct OrderSummaryResponceModel : Codable {

    let summary : Summary?
    let httpCode : Int?
    let message : String?
    let error: FloriaError?


    enum CodingKeys: String, CodingKey {
        case summary = "data"
        case httpCode = "http_code"
        case message = "message"
        case error
    }
    
    struct Summary : Codable {

        let delivery : Double?
        let subtotal : Double?
        let subTotalAfterDiscount: Double?
        let total : Double?
        let totalTax : Double?
        let discount: Double?
        enum CodingKeys: String, CodingKey {
            case delivery = "delivery"
            case subtotal = "subtotal"
            case total = "total"
            case totalTax = "total_tax"
            case subTotalAfterDiscount
            case discount
        }
    }
}


struct OrderSubmittResponseModel : Codable {

    let responseModel : ResponseModel?
    let httpCode : Int?
    let message : String?
    let error: FloriaError?

    enum CodingKeys: String, CodingKey {
        case responseModel = "data"
        case httpCode = "http_code"
        case message = "message"
        case error
    }
    struct ResponseModel : Codable {

        let id : Int?
        let paymentUrl: String?
        enum CodingKeys: String, CodingKey {
            case id = "id"
            case paymentUrl
        }
    }
}

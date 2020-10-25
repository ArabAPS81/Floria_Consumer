//
//  OrdersServices.swift
//  floriaConsumer
//
//  Created by Symsym on 31/12/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import Alamofire
import PKHUD

class OrdersServices {
    weak var delegate: WebServiceDelegate?
    
    init(delegate: WebServiceDelegate) {
        self.delegate = delegate
    }
    
    func getOrders(page:Int) {
        let baseUrl = (NetworkConstants.baseUrl + "orders?page=\(page)")
        guard let url = (baseUrl).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        
        
        let headers = WebServiceConfigure.getHeadersForAuthenticatedState()
        
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).responseData { (response) in
            switch response.result {
            case .success(let value):
                JSONResponseDecoder.decodeFrom(value, returningModelType: Orders.self) { (result, error) in
                    if result != nil {
                        self.delegate?.didRecieveData(data: result)
                    }
                }
            case .failure(let error):
                self.delegate?.didFailToReceiveDataWithError(error: error)
            }
        }
    }
    
    func getOrder(id:Int) {
        let baseUrl = (NetworkConstants.baseUrl + "orders/\(id)")
        guard let url = (baseUrl).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        
        
        let headers = WebServiceConfigure.getHeadersForAuthenticatedState()
        HUD.show(.progress)
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                JSONResponseDecoder.decodeFrom(response.data!, returningModelType: OrderModel.self) { (result, error) in
                    if result != nil {
                        HUD.flash(.success)
                        self.delegate?.didRecieveData(data: result)
                    }else{
                        HUD.flash(.error)
                        self.delegate?.didFailToReceiveDataWithError(error: error!)
                    }
                }
            case .failure(let error):
                HUD.flash(.error)
                self.delegate?.didFailToReceiveDataWithError(error: error)
            }
        }
    }
    
    func sendRate(orderId: Int, ratingV: Double,ratingP: Double, commentV: String,commentP: String) {
        let parameters = ["order_id" : orderId,
                          "product_rating" : ratingP,
                          "provider_rating" : ratingV,
                          "product_comment" : commentP,
                          "provider_comment" : commentV] as [String : Any]
        
        let url = NetworkConstants.baseUrl + "ratings"
        let headers = WebServiceConfigure.getHeadersForAuthenticatedState()
        
        ApiConnection.request(.post, url: url, parameters: parameters, headers: headers, showProgress: true, model: RateModel.self, completion: { (result) in
            self.delegate?.didRecieveData(data: result)
        }) { (error) in
            self.delegate?.didFailToReceiveDataWithError(error: error)
        }
    }
}

// MARK: - Order

struct OrderModel: Codable {
    let order: Order
    let message: String
    let httpCode: Int
    
    enum CodingKeys: String, CodingKey {
        case order = "data"
        case message = "message"
        case httpCode = "http_code"
    }
}


// MARK: - Orders

struct Orders: Codable {
    let orders: [Order]
    let links: Links
    let meta: Meta
    let httpCode: Int
    
    enum CodingKeys: String, CodingKey {
        case orders = "data"
        case links, meta
        case httpCode = "http_code"
    }
}

// MARK: - Order

struct Order: Codable {
    let id: Int
    let provider: Provider
    let status: Status
    let requiredAt, notes: String?
    let shipping: Int
    let subtotal, totalTax, delivery: Double
    let total: Double
    let isPaid: Int?
    let service: Service
    let products: [ProductElement]?
    let carDecoration: [CarDecoration]?
    let potsCare: [PotCare]?
    let address: [AddressModel.Address]?
    let payment_type_id: Int?
    let paymentMethod: String?
    
    enum CodingKeys: String, CodingKey {
        case id, provider, status
        case requiredAt = "required_at"
        case notes, shipping, subtotal
        case totalTax = "total_tax"
        case delivery, total, service, products, carDecoration, potsCare, address,payment_type_id
        case isPaid = "is_paid"
        case paymentMethod = "payment_method"
    }
}

// MARK: - Address

/*struct Address: Codable {
    let id: Int
    let name: String?
    let district: District
}*/

// MARK: - District

/*struct District: Codable {
    let id: Int
    let name: String?
}*/

// MARK: - ProductElement

struct ProductElement: Codable {
    let product: Product?
    let qunatity: Int?
}

// MARK: - ProductProduct

struct Product: Codable {
    let id: Int
    let name, productDescription: String?
    let image: String?
    let price, favoritesCount: Int
    let isFavorited: Bool
    let rate: Int
    let provider, service: AddressModel.District
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case productDescription = "description"
        case image, price, favoritesCount, isFavorited, rate, provider, service
    }
}

// MARK: - Provider

struct Provider: Codable {
    let name, mobile, image: String?
}

// MARK: - Service

struct Service: Codable {
    let id: Int
    let name: String?
    let image: String?
}

// MARK: - CarDecoration

struct CarDecoration: Codable {
    let car: Car
    let color: Color
    let decoration: Decoration
}

// MARK: - Car

struct Car: Codable {
    let id: Int
    let name: String
    let image: String
}

// MARK: - Decoration

struct Decoration: Codable {
    let id: Int
    let name, decorationDescription: String
    let image: String
    let price: Int

    enum CodingKeys: String, CodingKey {
        case id, name
        case decorationDescription = "description"
        case image, price
    }
}

// MARK: - PotCare

struct PotCare: Codable {
    let potSize: PotSize
    let numberOfPots: Int
    
    enum CodingKeys: String, CodingKey {
        case potSize
        case numberOfPots = "number_of_pots"
    }
}

// MARK: - PotSize

struct PotSize: Codable {
    let id: Int
    let name: String
}

// MARK: - Status

struct Status: Codable {
    let id: Int
    let name: String?
    let color: Color
}

// MARK: - Color

struct Color: Codable {
    let id: Int
    let name, code: String?
}

// MARK: - Links

struct Links: Codable {
    let first, last: String?
    let prev: String?
    let next: String?
}

// MARK: - Meta

struct Meta: Codable {
    let currentPage, lastPage: Int
    let path: String?
    let from, to: Int?
    let perPage, total: Int
    
    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case from
        case lastPage = "last_page"
        case path
        case perPage = "per_page"
        case to, total
    }
}


struct RateModel : Codable {

    //let data : Rate?
    let httpCode : Int?
    let message : String?


    enum CodingKeys: String, CodingKey {
        //case data
        case httpCode = "http_code"
        case message = "message"
    }
    
    struct Rate : Codable {

        let comment : String?
        let id : Int?
        let orderId : String?
        let rating : String?
        //let userId : Int?


        enum CodingKeys: String, CodingKey {
            case comment = "comment"
            case id = "id"
            case orderId = "order_id"
            case rating = "rating"
           // case userId = "user_id"
        }
    }

}


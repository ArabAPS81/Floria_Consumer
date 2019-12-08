//
//  ProductService.swift
//  FloriaNetworkLayer
//
//  Created by arabpas on 11/20/19.
//  Copyright © 2019 arabpas. All rights reserved.
//

import Foundation
import CoreLocation
import Alamofire


struct  FeaturedProductsQueryModel {
    var id: Int
    var Location: CLLocationCoordinate2D
}

struct  SearchProductsQueryModel {
    var id: Int
    var Location: CLLocationCoordinate2D
}

protocol WebServiceDelegate: class {
    
    func didRecieveData(data:Codable)
    func didFailToReceiveDataWithError(error: Error)
}

protocol WebserviceProtocol {
    init(delegate: WebServiceDelegate)
    var delegate:WebServiceDelegate? {set get}
}


class ProductService: WebserviceProtocol{
    
    weak var delegate: WebServiceDelegate?
    
    required init(delegate: WebServiceDelegate) {
        self.delegate = delegate
    }
    
    func getFeaturedProducts(model: FeaturedProductsQueryModel) {
        
        guard let urlString = (NetworkConstants.baseUrl + "PopularProduct" + "" ).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        let url = URL.init(string: urlString)!
        let parameters: [String: Any] = [:]
        let headers = WebServiceConfigure.getHeadersForAuthenticatedState()
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseData { (response) in
            switch response.result {
            case .success(let value):
//                JSONResponseDecoder.decodeFrom(value, returningModelType: [Product].self) { (result, error) in
//                    if let result = result {
//                        self.delegate?.didRecieveData(data: result)
//                    }
//                }
                break
            case .failure(let error):
                self.delegate?.didFailToReceiveDataWithError(error: error)
            }
        }
    }
    
    func searchInProducts(model: SearchProductsQueryModel) {
        
        guard let urlString = (NetworkConstants.baseUrl + "ShowOneProduct" + "" ).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        let url = URL.init(string: urlString)!
        let parameters: [String: Any] = [:]
        let headers = WebServiceConfigure.getHeadersForAuthenticatedState()
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseData { (response) in
            switch response.result {
            case .success(let value):
//                JSONResponseDecoder.decodeFrom(value, returningModelType: [Product].self) { (result, error) in
//                    if let result = result {
//                        self.delegate?.didRecieveData(data: result)
//                    }
//                }
                break
            case .failure(let error):
                self.delegate?.didFailToReceiveDataWithError(error: error)
            }
        }
    }
    
    
}





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
    var location: CLLocationCoordinate2D
}

struct  SearchProductsQueryModel {
    var id: Int
    var Location: CLLocationCoordinate2D
}

protocol WebServiceDelegate: class {
    
    func didRecieveData(data:Codable)
    func didFailToReceiveDataWithError(error: Error)
}


class ProductService {
    
    weak var delegate: WebServiceDelegate?
    
    init(delegate: WebServiceDelegate) {
        self.delegate = delegate
    }
    
    func getFeaturedProducts(model: FeaturedProductsQueryModel) {
        
        let baseUrl = (NetworkConstants.baseUrl + "nearest-popular-products?")
        let parameters = "lat=\(model.location.latitude)&lng=\(model.location.longitude)"
        guard let url = (baseUrl + parameters).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        let headers = WebServiceConfigure.getHeadersForUnauthenticatedState()
        Alamofire.request(url, method: .get, parameters: [:], encoding: URLEncoding.default, headers: headers).responseData { (response) in
            switch response.result {
            case .success(let value):
                JSONResponseDecoder.decodeFrom(value, returningModelType: ProductsModel.self) { (result, error) in
                    if let result = result {
                        self.delegate?.didRecieveData(data: result)
                    }
                }
            case .failure(let error):
                self.delegate?.didFailToReceiveDataWithError(error: error)
            }
        }
    }
    
    func getVendorsProducts(vendorId: Int) {
        
        let baseUrl = (NetworkConstants.baseUrl + "providers/" + "\(vendorId)" + "/products")
        guard let url = (baseUrl).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        let headers = WebServiceConfigure.getHeadersForUnauthenticatedState()
        Alamofire.request(url, method: .get, parameters: [:], encoding: URLEncoding.default, headers: headers).responseData { (response) in
            switch response.result {
            case .success(let value):
                JSONResponseDecoder.decodeFrom(value, returningModelType: ProductsModel.self) { (result, error) in
                    if let result = result {
                        self.delegate?.didRecieveData(data: result)
                    }
                }
            case .failure(let error):
                self.delegate?.didFailToReceiveDataWithError(error: error)
            }
        }
    }
    
    func getVendorsProducts(vendorId: Int, forService service: ServiceType) {
        
        let baseUrl = (NetworkConstants.baseUrl + "services/" + "\(service.serviceId())" + "/providers/" + "\(vendorId)" + "/products")
        guard let url = (baseUrl).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        let headers = WebServiceConfigure.getHeadersForUnauthenticatedState()
        Alamofire.request(url, method: .get, parameters: [:], encoding: URLEncoding.default, headers: headers).responseData { (response) in
            switch response.result {
            case .success(let value):
                JSONResponseDecoder.decodeFrom(value, returningModelType: ProductsModel.self) { (result, error) in
                    if let result = result {
                        self.delegate?.didRecieveData(data: result)
                    }
                }
            case .failure(let error):
                self.delegate?.didFailToReceiveDataWithError(error: error)
            }
        }
    }
    
    func getProduct(productId: Int) {
        
        let baseUrl = (NetworkConstants.baseUrl + "products/" + "\(productId)")
        guard let url = (baseUrl).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        let headers = WebServiceConfigure.getHeadersForUnauthenticatedState()
        Alamofire.request(url, method: .get, parameters: [:], encoding: URLEncoding.default, headers: headers).responseData { (response) in
            switch response.result {
            case .success(let value):
                JSONResponseDecoder.decodeFrom(value, returningModelType: ProductsModel.self) { (result, error) in
                    if let result = result {
                        self.delegate?.didRecieveData(data: result)
                    }
                }
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





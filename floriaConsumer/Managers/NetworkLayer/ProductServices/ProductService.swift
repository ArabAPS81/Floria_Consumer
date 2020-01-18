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
    var districtId: Int?
    var searchText: String
    var type: SearchType
    
    enum SearchType: String {
        case product,provider
    }
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
    
    func getProductsForVendor(_ vendorId: Int) {
        
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
    
    func getProductsForVendor(_ vendorId: Int, forService service: ServiceType) {
        
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
    
    func getVendorPackings(productId: Int) {
        
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
       // let model = SearchProductsQueryModel.init(districtId: nil, searchText: "test", type: SearchProductsQueryModel.SearchType.product)
        var baseUrl = NetworkConstants.baseUrl + "search?type=\(model.type)&search=\(model.searchText)"
        if let distId = model.districtId {
            baseUrl.append(contentsOf: "district_id=\(distId)")
        }
        
        guard let url = (baseUrl).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        let headers = WebServiceConfigure.getHeadersForUnauthenticatedState()
        Alamofire.request(url, method: .get, parameters: [:], encoding: URLEncoding.default, headers: headers).responseData { (response) in
            switch response.result {
            case .success(let value):
                
                if model.type == SearchProductsQueryModel.SearchType.product{
                    JSONResponseDecoder.decodeFrom(value, returningModelType: ProductsModel.self) { (result, error) in
                        if let result = result {
                            self.delegate?.didRecieveData(data: result)
                        }
                    }
                }else {
                    JSONResponseDecoder.decodeFrom(value, returningModelType: VendorsModel.self) { (result, error) in
                        if let result = result {
                            self.delegate?.didRecieveData(data: result)
                        }
                    }
                }
                
            case .failure(let error):
                self.delegate?.didFailToReceiveDataWithError(error: error)
            }
        }
    }
    
    func homeSliderData() {
        let baseUrl = NetworkConstants.baseUrl + "sliders"
        
        guard let url = (baseUrl).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        let headers = WebServiceConfigure.getHeadersForUnauthenticatedState()
        Alamofire.request(url, method: .get, parameters: [:], encoding: URLEncoding.default, headers: headers).responseData { (response) in
            switch response.result {
            case .success(let value):
                JSONResponseDecoder.decodeFrom(value, returningModelType: HomeSliderModel.self) { (result, error) in
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





//
//  VendorServices.swift
//  floriaConsumer
//
//  Created by arabpas on 12/11/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import Foundation
import CoreLocation
import Alamofire


struct  NearestVendorQueryModel {
    var location: CLLocationCoordinate2D
}

class VendorServices {
    
    private weak var delegate: WebServiceDelegate?
    
    init(delegate: WebServiceDelegate) {
        self.delegate = delegate
    }
    
    func getNearestVendors(model: NearestVendorQueryModel) {
        
        let baseUrl = (NetworkConstants.baseUrl + "nearest-providers?")
        let parameters = "lat=\(model.location.latitude)&lng=\(model.location.longitude)"
        guard let url = (baseUrl + parameters).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        let headers = WebServiceConfigure.getHeadersForUnauthenticatedState()
        Alamofire.request(url, method: .get, parameters: [:], encoding: URLEncoding.default, headers: headers).responseData { (response) in
            switch response.result {
            case .success(let value):
                JSONResponseDecoder.decodeFrom(value, returningModelType: VendorModel.self) { (result, error) in
                    if let result = result {
                        self.delegate?.didRecieveData(data: result)
                    }
                }
            case .failure(let error):
                self.delegate?.didFailToReceiveDataWithError(error: error)
            }
        }
    }
    
    func getVendorsByService(service:ServiceType, model: NearestVendorQueryModel) {
        
        let baseUrl = (NetworkConstants.baseUrl + "services/" + service.serviceId() + "/providers?")
        let parameters = "lat=\(model.location.latitude)&lng=\(model.location.longitude)"
        guard let url = (baseUrl + parameters).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        let headers = WebServiceConfigure.getHeadersForUnauthenticatedState()
        Alamofire.request(url, method: .get, parameters: [:], encoding: URLEncoding.default, headers: headers).responseData { (response) in
            switch response.result {
            case .success(let value):
                JSONResponseDecoder.decodeFrom(value, returningModelType: VendorModel.self) { (result, error) in
                    if let result = result {
                        self.delegate?.didRecieveData(data: result)
                    }
                }
            case .failure(let error):
                self.delegate?.didFailToReceiveDataWithError(error: error)
            }
        }
    }
    
    func getProductExtrasFor(vendor vendorId: Int) {
        
        let baseUrl = (NetworkConstants.baseUrl + "providers/" + "\(vendorId)" + "/extras")
        guard let url = (baseUrl).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        let headers = WebServiceConfigure.getHeadersForUnauthenticatedState()
        Alamofire.request(url, method: .get, parameters: [:], encoding: URLEncoding.default, headers: headers).responseData { (response) in
            switch response.result {
            case .success(let value):
                JSONResponseDecoder.decodeFrom(value, returningModelType: ProductPackingModel.self) { (result, error) in
                    if let result = result {
                        self.delegate?.didRecieveData(data: result)
                    }
                }
            case .failure(let error):
                self.delegate?.didFailToReceiveDataWithError(error: error)
            }
        }
    }
    
    func getProductPackingsFor(vendor vendorId: Int) {
        
        let baseUrl = (NetworkConstants.baseUrl + "providers/" + "\(vendorId)" + "/packings")
        guard let url = (baseUrl).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        let headers = WebServiceConfigure.getHeadersForUnauthenticatedState()
        Alamofire.request(url, method: .get, parameters: [:], encoding: URLEncoding.default, headers: headers).responseData { (response) in
            switch response.result {
            case .success(let value):
                JSONResponseDecoder.decodeFrom(value, returningModelType: ProductPackingModel.self) { (result, error) in
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





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
import PKHUD


struct  NearestVendorQueryModel {
    var location: CLLocationCoordinate2D
}
struct FilterModel {
    var district:Int
}

class VendorServices {
    
    private weak var delegate: WebServiceDelegate?
    
    init(delegate: WebServiceDelegate) {
        self.delegate = delegate
    }
    
    func getNearestVendors(model: NearestVendorQueryModel) {
        
        let baseUrl = (NetworkConstants.baseUrl + "nearest-providers?")
        let parameters = "lat=30.063049&lng=31.346661"
        guard let url = (baseUrl + parameters).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        let headers = WebServiceConfigure.getHeadersForUnauthenticatedState()
        Alamofire.request(url, method: .get, parameters: [:], encoding: URLEncoding.default, headers: headers).responseData { (response) in
            switch response.result {
            case .success(let value):
                JSONResponseDecoder.decodeFrom(value, returningModelType: VendorsModel.self) { (result, error) in
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
        let headers = WebServiceConfigure.getHeadersForAuthenticatedState()
        Alamofire.request(url, method: .get, parameters: [:], encoding: URLEncoding.default, headers: headers).responseData { (response) in
            switch response.result {
            case .success(let value):
                JSONResponseDecoder.decodeFrom(value, returningModelType: VendorsModel.self) { (result, error) in
                    if let result = result {
                        self.delegate?.didRecieveData(data: result)
                    }else{
                        self.delegate?.didFailToReceiveDataWithError(error: error!)
                    }
                }
            case .failure(let error):
                self.delegate?.didFailToReceiveDataWithError(error: error)
            }
        }
    }
    
    func getVendorsByService(service:ServiceType, andFilter model: FilterModel) {
        
        let baseUrl = (NetworkConstants.baseUrl + "services/" + service.serviceId() + "/providers?")
        let parameters = "district_id=\(model.district)"
        guard let url = (baseUrl + parameters).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        let headers = WebServiceConfigure.getHeadersForAuthenticatedState()
        Alamofire.request(url, method: .get, parameters: [:], encoding: URLEncoding.default, headers: headers).responseData { (response) in
            switch response.result {
            case .success(let value):
                JSONResponseDecoder.decodeFrom(value, returningModelType: VendorsModel.self) { (result, error) in
                    if let result = result {
                        self.delegate?.didRecieveData(data: result)
                    }
                }
            case .failure(let error):
                self.delegate?.didFailToReceiveDataWithError(error: error)
            }
        }
    }
    
    func getVendorsDetails(vendorId: Int) {
        HUD.show(.progress)
        let baseUrl = NetworkConstants.baseUrl + "providers/\(vendorId)"
        guard let url = baseUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        let headers = WebServiceConfigure.getHeadersForAuthenticatedState()
        Alamofire.request(url, method: .get, parameters: [:], encoding: URLEncoding.default, headers: headers).responseData { (response) in
            switch response.result {
            case .success(let value):
                JSONResponseDecoder.decodeFrom(value, returningModelType: VendorDetailsModel.self) { (result, error) in
                    if let result = result {
                        self.delegate?.didRecieveData(data: result)
                        HUD.flash(.success)
                    }else{
                        self.delegate?.didFailToReceiveDataWithError(error: error!)
                        HUD.flash(.error)
                        
                    }
                }
            case .failure(let error):
                self.delegate?.didFailToReceiveDataWithError(error: error)
                HUD.flash(.error)
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





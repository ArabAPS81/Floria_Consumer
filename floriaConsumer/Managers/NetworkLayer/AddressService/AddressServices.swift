//
//  AddressServices.swift
//  floriaConsumer
//
//  Created by arabpas on 12/17/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import Foundation
import CoreLocation
import Alamofire



struct  SubmittAddressQueryModel {
    var products: [Product]
    struct Product {
        var id: Int
        var quantity: Int
        var price: Double
    }
    
}

class AddressService {
    
    weak var delegate: WebServiceDelegate?
    
    init(delegate: WebServiceDelegate) {
        self.delegate = delegate
    }
    
    func getListOfAddresses(model: FeaturedProductsQueryModel) {
        
        guard let baseUrl = (NetworkConstants.baseUrl + "addresses?").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        let headers = WebServiceConfigure.getHeadersForAuthenticatedState()
        Alamofire.request(baseUrl, method: .get, parameters: [:], encoding: URLEncoding.default, headers: headers).responseData { (response) in
            switch response.result {
            case .success(let value):
                JSONResponseDecoder.decodeFrom(value, returningModelType: AddressModel.self) { (result, error) in
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





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

//name:46 ابن النفيس الدور الرابع
//street_name:الهيثم
//district_id:3
//apartment_number:
//building_number:
//street_name:
//mobile:
//another_mobile:
//postal_code:
//notes:

struct  SubmittAddressQueryModel: Codable {
    var name: String?
    var streetName: String?
    var districtId: Int?
    var phoneNum: String?
    var notes: String?
    
    enum CodingKeys: String, CodingKey {
        case districtId = "district_id"
        case phoneNum = "mobile"
        case name = "name"
        case notes = "notes"
        case streetName = "street_name"
    }
//    var location: Location2D?
//
//    struct Location2D:Codable {
//        var long:Double?
//        var latt:Double?
//    }
}

class AddressService {
    
    weak var delegate: WebServiceDelegate?
    
    init(delegate: WebServiceDelegate) {
        self.delegate = delegate
    }
    
    func getListOfAddresses() {
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
    
    func addAddress(address:SubmittAddressQueryModel) {
        guard let baseUrl = (NetworkConstants.baseUrl + "addresses").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        let jsonData = (try? JSONEncoder().encode(address)) ?? Data()
        let json = try? JSONSerialization.jsonObject(with: jsonData, options:[]) as? [String:Any]
        let headers = WebServiceConfigure.getHeadersForAuthenticatedState()
        Alamofire.request(baseUrl, method: .post, parameters: json, encoding: JSONEncoding.default, headers: headers).responseData { (response) in
            switch response.result {
            case .success(let value):
                JSONResponseDecoder.decodeFrom(value, returningModelType: AddAddressResponseModel.self) { (result, error) in
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

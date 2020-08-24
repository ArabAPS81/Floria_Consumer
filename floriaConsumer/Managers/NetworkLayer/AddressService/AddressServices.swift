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
import PKHUD


struct  SubmittAddressQueryModel: Codable {
    var name: String?
    var streetName: String?
    var districtId: Int?
    var phoneNum: String?
    var apartmentNumber: String?
    var buildingNumber: String?
    var contactName: String?
    var notes: String?
    
    enum CodingKeys: String, CodingKey {
        case apartmentNumber = "apartment_number"
        case buildingNumber = "building_number"
        case contactName = "contact_name"
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
    
    func getListOfGovs() {
        guard let baseUrl = (NetworkConstants.baseUrl + "governorates?").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        let headers = WebServiceConfigure.getHeadersForUnauthenticatedState()
        Alamofire.request(baseUrl, method: .get, parameters: [:], encoding: URLEncoding.default, headers: headers).responseData { (response) in
            switch response.result {
            case .success(let value):
                JSONResponseDecoder.decodeFrom(value, returningModelType: GovernorateModel.self) { (result, error) in
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
        HUD.show(.progress)
        guard let baseUrl = (NetworkConstants.baseUrl + "addresses").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        let jsonData = (try? JSONEncoder().encode(address)) ?? Data()
        let json = try? JSONSerialization.jsonObject(with: jsonData, options:[]) as? [String:Any]
        let headers = WebServiceConfigure.getHeadersForAuthenticatedState()
        Alamofire.request(baseUrl, method: .post, parameters: json, encoding: JSONEncoding.default, headers: headers).responseData { (response) in
            switch response.result {
            case .success(let value):
                JSONResponseDecoder.decodeFrom(value, returningModelType: AddAddressResponseModel.self) { (result, error) in
                    if let result = result {
                        HUD.flash(.success)
                        self.delegate?.didRecieveData(data: result)
                    }else {
                        HUD.flash(.error)
                    }
                }
            case .failure(let error):
                HUD.flash(.error)
                self.delegate?.didFailToReceiveDataWithError(error: error)
            }
        }
    }
    
    func editAddress(address:SubmittAddressQueryModel, id: Int) {
        guard let baseUrl = (NetworkConstants.baseUrl + "addresses/\(id)").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        let jsonData = (try? JSONEncoder().encode(address)) ?? Data()
        let json = try? JSONSerialization.jsonObject(with: jsonData, options:[]) as? [String:Any]
        let headers = WebServiceConfigure.getHeadersForAuthenticatedState()
        Alamofire.request(baseUrl, method: .put, parameters: json, encoding: JSONEncoding.default, headers: headers).responseData { (response) in
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
    
    func deleteAddress(id: Int) {
        let url = NetworkConstants.baseUrl + "addresses/\(id)"
        let header = WebServiceConfigure.getHeadersForAuthenticatedState()
        ApiConnection.request(.delete, url: url,headers: header , model: ComplainModel.self, completion: { (result) in
            self.delegate?.didRecieveData(data: result)
        }) { (error) in
            self.delegate?.didFailToReceiveDataWithError(error: error)
        }
    }
    
}

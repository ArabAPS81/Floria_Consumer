//
//  GeneralServices.swift
//  floriaConsumer
//
//  Created by arabpas on 3/16/20.
//  Copyright © 2020 Obida. All rights reserved.
//

import Foundation
import Alamofire
import PKHUD


class GeneralServices {
    
    weak var delegate: WebServiceDelegate?
    
    init(delegate: WebServiceDelegate) {
        self.delegate = delegate
    }
    
    func getGeneralData() {
        let url = NetworkConstants.baseUrl + "general"
        let headers = WebServiceConfigure.getHeadersForUnauthenticatedState()
        ApiConnection.request(.get, url: url, headers: headers, showProgress: true, model: GeneralModel.self, completion: { (result) in
            self.delegate?.didRecieveData(data: result)
        }) { (error) in
            self.delegate?.didFailToReceiveDataWithError(error: error)
        }
    }
    
    func payOrder(_ orderId:Int, paymentNum:String) {
        let url = NetworkConstants.baseUrl + "confirm-payment/\(orderId)"
        
        let headers = WebServiceConfigure.getHeadersForAuthenticatedState()
        ApiConnection.request(.post, url: url, parameters: [:], headers: headers, showProgress: true, model: ComplainModel.self, completion: { (result) in
            self.delegate?.didRecieveData(data: result)
        }) { (error) in
            self.delegate?.didFailToReceiveDataWithError(error: error)
        }
        
    }
    
    func submittSupportMessage(_ content:String, title:String) {
        let url = NetworkConstants.baseUrl + "complaint"
        let params = ["title" : title,
                      "content" : content]
        let headers = WebServiceConfigure.getHeadersForAuthenticatedState()
        ApiConnection.request(.post, url: url, parameters: params, headers: headers, showProgress: true, model: ComplainModel.self, completion: { (result) in
            self.delegate?.didRecieveData(data: result)
        }) { (error) in
            self.delegate?.didFailToReceiveDataWithError(error: error)
        }
        
    }
    
    
    func submittSupportMessageWithFile(_ content:String, title:String, image: Data?) {
        HUD.show(.progress)
        let url = NetworkConstants.baseUrl + "complaint"
        let headers = WebServiceConfigure.getHeadersForAuthenticatedState()
        Alamofire.upload(multipartFormData: { (MPFData) in
            if let image = image {
                MPFData.append(image, withName: "attachment",fileName: "file.png",mimeType: "image/png")
            }
            MPFData.append(title.data(using: .utf8)!, withName: "title")
            MPFData.append(content.data(using: .utf8)!, withName: "content")
        }, to: url,method: .post, headers: headers) { (result) in
            switch result{
            case .success(let upload,_,_):
                upload.responseData { (response) in
                    switch response.result{
                    case .success:
                        JSONResponseDecoder.decodeFrom(response.data!, returningModelType: ComplainModel.self) { (result, error) in
                            if error == nil {
                                if result?.errors == nil {
                                    HUD.flash(.success)
                                    self.delegate?.didRecieveData(data: result!)
                                }else{
                                    HUD.flash(.error)
                                    self.delegate?.didRecieveData(data: result!)
                                }
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
                
            case .failure(let error):
                HUD.flash(.error)
                self.delegate?.didFailToReceiveDataWithError(error: error)
            }
        }
    }
    
    
}





struct ComplainModel : Codable {
    
    let httpCode : Int?
    let message : String?
    let errors : FloriaError?
    
    
    enum CodingKeys: String, CodingKey {
        case httpCode = "http_code"
        case message = "message"
        case errors = "error"
    }
}

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct GeneralModel: Codable {
    let httpCode: Int
    let data: DataClass

    enum CodingKeys: String, CodingKey {
        case httpCode = "http_code"
        case data
    }
    
    // MARK: - DataClass
    struct DataClass: Codable {
        let services, carTypes: [CarType]
        let colors: [Color]
        let decorationTypes: [DecorationType]
        let potSizes: [PotSize]
        let orderStatuses: [OrderStatus]
        let termsAndConditions: [TermsAndCondition]
    }

    // MARK: - CarType
    struct CarType: Codable {
        let id: Int
        let name: String
        let image: String
    }

    // MARK: - Color
    struct Color: Codable {
        let id: Int
        let name, code: String
    }

    // MARK: - DecorationType
    struct DecorationType: Codable {
        let id: Int
        let name, decorationTypeDescription: String
        let image: String
        let price: Int?

        enum CodingKeys: String, CodingKey {
            case id, name
            case decorationTypeDescription = "description"
            case image, price
        }
    }

    // MARK: - OrderStatus
    struct OrderStatus: Codable {
        let id: Int
        let name: String
        let color: Color
    }

    // MARK: - PotSize
    struct PotSize: Codable {
        let id: Int
        let name: String
    }

    // MARK: - TermsAndCondition
    struct TermsAndCondition: Codable {
        let content: String
    }

    
}


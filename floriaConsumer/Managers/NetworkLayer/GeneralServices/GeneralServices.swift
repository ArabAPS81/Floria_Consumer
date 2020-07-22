//
//  GeneralServices.swift
//  floriaConsumer
//
//  Created by arabpas on 3/16/20.
//  Copyright © 2020 Obida. All rights reserved.
//

import Foundation
import Alamofire


class GeneralServices {
    
    weak var delegate: WebServiceDelegate?
    
    init(delegate: WebServiceDelegate) {
        self.delegate = delegate
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
    
    func submittSupportMessageWithFile(_ content:String, title:String, image: Data) {
        let url = NetworkConstants.baseUrl + "complaint"
        let headers = WebServiceConfigure.getHeadersForAuthenticatedState()
        Alamofire.upload(multipartFormData: { (MPFData) in
            MPFData.append(image, withName: "attachment",fileName: "file.png",mimeType: "image/png")
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
                                self.delegate?.didRecieveData(data: result!)
                            }else{
                                self.delegate?.didFailToReceiveDataWithError(error: error!)
                            }
                        }
                    case .failure(let error):
                        self.delegate?.didFailToReceiveDataWithError(error: error)
                    }
                }
                
            case .failure(let error):
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


//
//  GeneralServices.swift
//  floriaConsumer
//
//  Created by arabpas on 3/16/20.
//  Copyright © 2020 Obida. All rights reserved.
//

import Foundation


class GeneralServices {
    
    weak var delegate: WebServiceDelegate?
    
    init(delegate: WebServiceDelegate) {
        self.delegate = delegate
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
}

struct ComplainModel : Codable {
    
    let httpCode : Int?
    let message : String?
    
    
    enum CodingKeys: String, CodingKey {
        case httpCode = "http_code"
        case message = "message"
    }
}

//
//  FavoriteServices.swift
//  floriaConsumer
//
//  Created by arabpas on 3/9/20.
//  Copyright © 2020 Obida. All rights reserved.
//

import Foundation

class FavoriteServices {
    
    private weak var delegate: WebServiceDelegate?
    
    init(delegate: WebServiceDelegate) {
        self.delegate = delegate
    }
    
    func setProductFavorite(_ id: Int) {
        let baseUrl = (NetworkConstants.baseUrl + "favorites")
        let parameters: [String: Any] = ["id": 1, "model": "product"]
        
        ApiConnection.request(.post, url: baseUrl, parameters: parameters, model: FavoriteResponse.self, completion: { (result) in
            self.delegate?.didRecieveData(data: result)
        }) { (error) in
            self.delegate?.didFailToReceiveDataWithError(error: error)
        }
    }
    
    func setProviderFavorite(_ id: Int) {
        let baseUrl = (NetworkConstants.baseUrl + "favorites")
        let parameters: [String: Any] = ["id": 1, "model": "provider"]
        ApiConnection.request(.post, url: baseUrl, parameters: parameters, model: FavoriteResponse.self, completion: { (result) in
            self.delegate?.didRecieveData(data: result)
        }) { (error) in
            self.delegate?.didFailToReceiveDataWithError(error: error)
        }
    }
    
}

struct FavoriteResponse: Codable {
    
}

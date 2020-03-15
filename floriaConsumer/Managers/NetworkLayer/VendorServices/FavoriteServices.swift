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
        let parameters: [String: Any] = ["id": id, "model": "product"]
        let headers = WebServiceConfigure.getHeadersForAuthenticatedState()
        ApiConnection.request(.post, url: baseUrl, parameters: parameters, headers: headers, model: FavoriteResponse.self, completion: { (result) in
            self.delegate?.didRecieveData(data: result)
        }) { (error) in
            self.delegate?.didFailToReceiveDataWithError(error: error)
        }
    }
    func setProductUnFavorite(_ id: Int) {
        let baseUrl = (NetworkConstants.baseUrl + "favorites?id=\(id)&model=product")
        let headers = WebServiceConfigure.getHeadersForAuthenticatedState()
        ApiConnection.request(.delete, url: baseUrl, headers: headers, model: FavoriteResponse.self, completion: { (result) in
            self.delegate?.didRecieveData(data: result)
        }) { (error) in
            self.delegate?.didFailToReceiveDataWithError(error: error)
        }
    }
    
    func setProviderFavorite(_ id: Int) {
        let baseUrl = (NetworkConstants.baseUrl + "favorites")
        let parameters: [String: Any] = ["id": id, "model": "provider"]
        let headers = WebServiceConfigure.getHeadersForAuthenticatedState()
        ApiConnection.request(.post, url: baseUrl, parameters: parameters, headers: headers, model: FavoriteResponse.self, completion: { (result) in
            self.delegate?.didRecieveData(data: result)
        }) { (error) in
            self.delegate?.didFailToReceiveDataWithError(error: error)
        }
    }
    
    func setProviderUnFavorite(_ id: Int) {
        let baseUrl = (NetworkConstants.baseUrl + "favorites?id=\(id)&model=provider")
        let headers = WebServiceConfigure.getHeadersForAuthenticatedState()
        ApiConnection.request(.delete, url: baseUrl, headers: headers, model: FavoriteResponse.self, completion: { (result) in
            self.delegate?.didRecieveData(data: result)
        }) { (error) in
            self.delegate?.didFailToReceiveDataWithError(error: error)
        }
    }
    func getProductsFavoriteList() {
        let baseUrl = (NetworkConstants.baseUrl + "favorite-products")
        let headers = WebServiceConfigure.getHeadersForAuthenticatedState()
        ApiConnection.request(.get, url: baseUrl, headers: headers, model: ProductsModel.self, completion: { (result) in
            self.delegate?.didRecieveData(data: result)
        }) { (error) in
            self.delegate?.didFailToReceiveDataWithError(error: error)
        }
    }
    
    func getVendorsFavoriteList() {
        let baseUrl = (NetworkConstants.baseUrl + "favorite-providers")
        let headers = WebServiceConfigure.getHeadersForAuthenticatedState()
        ApiConnection.request(.get, url: baseUrl, headers: headers, model: VendorsModel.self, completion: { (result) in
            self.delegate?.didRecieveData(data: result)
        }) { (error) in
            self.delegate?.didFailToReceiveDataWithError(error: error)
        }
    }
    
}

struct FavoriteResponse: Codable {
    let httpCode: Int?
    let data: FavoriteObj?
    let message: String?
    
    enum CodingKeys: String, CodingKey {
        case data
        case httpCode = "http_code"
        case message
    }
    
    struct FavoriteObj: Codable {
        let isFavorited: Bool?
    }
}

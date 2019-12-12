//
//  ProductsListPresenter.swift
//  floriaConsumer
//
//  Created by arabpas on 12/12/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import Foundation

class ProductsListPresenter {
    
    weak var view: ProductsListView?
    
    init(view: ProductsListView) {
        self.view = view
    }
    
    func getVendorProducts(vendor: Int) {
        let service = ProductService.init(delegate: self)
        service.getVendorsProducts(vendorId: vendor)
    }
}

extension ProductsListPresenter: WebServiceDelegate {
    func didRecieveData(data: Codable) {
        view?.didReceiveData(data: data)
    }
    func didFailToReceiveDataWithError(error: Error) {
        view?.didFailToReceiveData(error: error)
    }
}

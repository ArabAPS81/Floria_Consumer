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
    
    func getVendorProducts(vendorId: Int, forService serviceType: ServiceType) {
        let service = ProductService.init(delegate: self)
        service.getVendorsProducts(vendorId: vendorId, forService: serviceType)
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

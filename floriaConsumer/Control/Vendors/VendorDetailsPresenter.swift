//
//  VendorDetailsPresenter.swift
//  floriaConsumer
//
//  Created by Mariam Elenna on 12/20/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import Foundation

class VendorDetailsPresenter {
    
    private weak var view: VendorDetailsView?
    
    init(view: VendorDetailsView) {
        self.view = view
    }
    
    func getVendorProducts(vendorId : Int, page: Int) {
        let productService = ProductService.init(delegate: self)
        productService.getProductsForVendor(vendorId,page: page)
    }
    
    func getVendorDetails(vendorId: Int) {
        let productService = VendorServices.init(delegate: self)
        productService.getVendorsDetails(vendorId: vendorId)
    }
    
}

extension VendorDetailsPresenter : WebServiceDelegate {
    func didRecieveData(data: Codable) {
        view?.didReceiveData(data: data)
        
    }
    
    func didFailToReceiveDataWithError(error: Error) {
        view?.didFailToReceiveData(error: error)
    }
    
    
    
}

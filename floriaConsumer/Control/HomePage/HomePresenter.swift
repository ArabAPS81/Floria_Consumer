//
//  HomePresenter.swift
//  floriaConsumer
//
//  Created by arabpas on 12/11/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import Foundation


class HomePresenter {
    
    private weak var view: HomeView?
    
    init(view: HomeView) {
        self.view = view
    }
    
    func getNearestVendor() {
        let service = VendorServices.init(delegate: self)
        let model = NearestVendorQueryModel.init(location: LocationManager.sharedManager.userCurrentCoordinate)
        service.getNearestVendors(model: model)
    }
    
    func getFeaturedProducts() {
        let service = ProductService.init(delegate: self)
        let model = FeaturedProductsQueryModel.init(location: LocationManager.sharedManager.userCurrentCoordinate)
        service.getFeaturedProducts(model: model)
    }
    
}

extension HomePresenter : WebServiceDelegate {
    func didRecieveData(data: Codable) {
        view?.didReceiveData(data: data)
        
    }
    
    func didFailToReceiveDataWithError(error: Error) {
        view?.didFailToReceiveData(error: error)
    }
    
    
    
}

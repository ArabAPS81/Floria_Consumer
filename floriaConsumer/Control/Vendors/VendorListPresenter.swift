//
//  VendorListPresenter.swift
//  floriaConsumer
//
//  Created by arabpas on 12/12/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import Foundation

class VendorListPresenter {
    
    weak var view: VendorsListView?
    
    init(view: VendorsListView) {
        self.view = view
    }
    
    func getVendorsList(serviceType: ServiceType) {
        let service = VendorServices.init(delegate: self)
        let model = NearestVendorQueryModel.init(location: LocationManager.sharedManager.userCurrentCoordinate)
        service.getVendorsByService(service: serviceType, model: model)
    }
}

extension VendorListPresenter: WebServiceDelegate {
    func didRecieveData(data: Codable) {
        view?.didReceiveData(data: data)
    }
    
    func didFailToReceiveDataWithError(error: Error) {
        view?.didFailToReceiveData(error: error)
    }
    
    
}

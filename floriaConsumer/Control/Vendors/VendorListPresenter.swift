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
    private var serviceType: ServiceType?
    
    func getVendorsList(serviceType: ServiceType,page:Int) {
        self.serviceType = serviceType
        let service = VendorServices.init(delegate: self)
        let model = NearestVendorQueryModel.init(location:nil, page: page)
        service.getVendorsByService(service: serviceType, model: model)
    }
    func getVendorsList(serviceType: ServiceType, andFilter model: FilterModel, page:Int) {
        let service = VendorServices.init(delegate: self)
        service.getVendorsByService(service: serviceType,andFilter: model, page: page)
    }
}

extension VendorListPresenter: WebServiceDelegate {
    func didRecieveData(data: Codable) {
        if let model = data as? VendorsModel {
            if model.vendors.count == 0 {
                let service = VendorServices.init(delegate: self)
                let getModel = NearestVendorQueryModel.init(location:nil)
                service.getVendorsByService(service: serviceType!, model: getModel)
            }else{
                
            }
            view?.didReceiveData(data: data)
        }
        
    }
    
    func didFailToReceiveDataWithError(error: Error) {
        view?.didFailToReceiveData(error: error)
    }
    
    
}

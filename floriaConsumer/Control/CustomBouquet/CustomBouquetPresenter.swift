//
//  CustomBouquetPresenter.swift
//  floriaConsumer
//
//  Created by arabpas on 12/15/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import Foundation

class CustomBouquetPresenter {
    
    private weak var view: CustomBouquetView?
    private var productsList = [ProductsModel.Product]()
    private var selectedProducts = SubmittOrderQueryModel()
    
    init(view: CustomBouquetView) {
        self.view = view
    }
    
    func numberOfItemsInSection(section:Int) -> Int {
        return productsList.count
    }
    
    func dataForCellAt(indexPath:IndexPath) -> ProductsModel.Product {
        return productsList[indexPath.row]
    }
    
    func getVendorProducts(vendorId: Int, forService serviceType: ServiceType) {
        let service = ProductService.init(delegate: self)
        service.getProductsForVendor(vendorId, forService: serviceType)
    }
}

extension CustomBouquetPresenter: WebServiceDelegate {
    func didRecieveData(data: Codable) {
        if let data = data as? ProductsModel{
            productsList = data.products ?? []
        }
        view?.didReceiveData(data: data)
    }
    func didFailToReceiveDataWithError(error: Error) {
        view?.didFailToReceiveData(error: error)
    }
}

extension CustomBouquetPresenter: CustomBouquetCellDelegate {
    func addItem(id: Int, count: Int) {
        if count > 0 {
            if var item = selectedProducts.products!.filter({ (item) -> Bool in
                return item.id == id
            }).first {
                item.quantity = count
            } else {
                
                }
            }
        }
    }
    



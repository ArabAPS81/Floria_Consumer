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
    private var selectedProducts = orderRequest
    
    init(view: CustomBouquetView) {
        self.view = view
    }
    
    func numberOfItemsInSection(section:Int) -> Int {
        return productsList.count
    }
    
    func dataForCellAt(indexPath:IndexPath) -> ProductsModel.Product {
        return productsList[indexPath.row]
    }
    
    func getVendorProducts(vendorId: Int, forService serviceType: ServiceType,page:Int) {
        let service = ProductService.init(delegate: self)
        service.getProductsForVendor(vendorId, forService: serviceType,page: page)
    }
    
    func submittOrder() {
        print(selectedProducts)
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
        
        selectedProducts.products.removeAll(where: { (product) -> Bool in
            return product.id == id
        })
        
        let price = productsList.filter { (product) -> Bool in
            return product.id == id
        }.first?.price ?? 0.0
        if count > 0 {
            selectedProducts.products.append(SubmittOrderQueryModel.OrderProducts.init(id: id, quantity: count, price: price))
        }
        
    }
}
    



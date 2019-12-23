//
//  ServiceCollectionDataSource.swift
//  floriaConsumer
//
//  Created by Mariam Elenna on 12/19/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import Foundation
import UIKit

class ServiceCollectionDataSource : NSObject,UICollectionViewDelegate , UICollectionViewDataSource{
    let services:[VendorModel.Service]
    init(services:[VendorModel.Service]) {
        self.services = services
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return services.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let service = services[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "serviceCell", for: indexPath) as! ServicesCollectionViewCell
        cell.putDataToViews(service: service)
        return cell
    }
    
}

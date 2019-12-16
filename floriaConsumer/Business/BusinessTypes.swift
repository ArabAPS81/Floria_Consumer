//
//  BusinessTypes.swift
//  floriaConsumer
//
//  Created by arabpas on 12/10/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import UIKit


enum ServiceType {
    case readyMade,gerb,customBouquet,carDecoration,potsCare
    
    func getTitle() -> String {
        switch self {
        case .readyMade:
            return "Ready made"
        case .gerb:
            return "Gerb"
        case .customBouquet:
            return "Custom bouquet"
        case .carDecoration:
            return "Car decoration"
        case .potsCare:
            return "Pots care"
        }
    }
    
    func serviceId() -> String {
        switch self {
        case .readyMade:
            return "1"
        case .gerb:
            return "3"
        case .customBouquet:
            return "2"
        case .carDecoration:
            return "4"
        case .potsCare:
            return "5"
        }
    }
    
    func associatedViewController(_ vendorId: Int? = 1) -> UIViewController {
        switch self {
        case .readyMade:
            return ProductListViewController.newInstance(listType: ServiceType.readyMade)
        case .gerb:
            return ProductListViewController.newInstance(listType: ServiceType.gerb)
        case .customBouquet:
            return CustomBouquetViewController.newInstance(vendorID: vendorId ?? 1)
        case .carDecoration:
            return CarDecorationViewController.newInstance()
        case .potsCare:
            return PotsCareReviewViewController.newInstance()
        }
    }
    
    func afterAddressViewController() -> UIViewController{
        switch self {
        case .readyMade:
            return shipping.newInstance(serviceType: .readyMade)
        case .gerb:
            return shipping.newInstance(serviceType: .gerb)
        case .customBouquet:
            return shipping.newInstance(serviceType: .customBouquet)
        case .carDecoration:
            return CarDecorationViewController.newInstance()
        case .potsCare:
            let vc = VendorsListViewController.newInstance(service: self)
            return vc
        }
    }
    
    private func getTitle2() {
        switch self {
        case .readyMade:
            break
        case .gerb:
            break
        case .customBouquet:
            break
        case .carDecoration:
            break
        case .potsCare:
            break
        }
    }
    
}

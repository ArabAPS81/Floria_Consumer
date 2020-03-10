//
//  ServicesCollectionViewCell.swift
//  floriaConsumer
//
//  Created by Mariam Elenna on 12/20/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import UIKit

class ServicesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    func putDataToViews(service: VendorsModel.Service) {
        name.text = service.name
        switch service.id {
        case 1:
            img.image = #imageLiteral(resourceName: "FlowerBoket")
        case 2:
            img.image = #imageLiteral(resourceName: "FlowerZohria")
        case 3:
            img.image = #imageLiteral(resourceName: "BoketWard")
        case 4:
            img.image = #imageLiteral(resourceName: "CarWedding")
        case 5:
            img.image = #imageLiteral(resourceName: "HomeFlowers")
        default:
            break
        }
    }
}

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
        
        img.imageFromUrl(url: service.image, placeholder: nil)
    }
}

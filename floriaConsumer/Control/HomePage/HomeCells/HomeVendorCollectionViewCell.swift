//
//  HomeVendorCollectionViewCell.swift
//  floriaConsumer
//
//  Created by arabpas on 11/27/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import UIKit

class HomeVendorCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var shadowedView: UIView!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var vendorNameLabel: UILabel!
    @IBOutlet weak var vendorDistrictLabel: UILabel!
    @IBOutlet weak var ratingView: RateView!
    
    func cofigure(vendor: VendorModel.Vendor) {
        vendorNameLabel.text = vendor.name
        vendorDistrictLabel.text = vendor.district?.name
        imageView.imageFromUrl(url: vendor.image, placeholder: nil)
        ratingView.setRate(rate: 5)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.shadowedView.dropRoundedShadowForAllSides(5)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        shadowedView.layer.cornerRadius = 5
        
        
    }

}

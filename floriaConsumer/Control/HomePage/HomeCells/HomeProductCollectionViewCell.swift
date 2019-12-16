//
//  HomeProductCollectionViewCell.swift
//  floriaConsumer
//
//  Created by arabpas on 11/27/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import UIKit

class HomeProductCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "HomeProductCollectionViewCell"
    static func registerNIBinView(collection: UICollectionView) {
        let nib = UINib.init(nibName: reuseId, bundle: nil)
        collection.register(nib, forCellWithReuseIdentifier: reuseId)
    }
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var vendorNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var ratingView: RateView!
    @IBOutlet weak var shadowedView: UIView!
    
    func cofigure(product: ProductsModel.Product) {
        nameLabel.text = product.name
        priceLabel.text = product.price
        vendorNameLabel.text = product.provider?.name
        imageView.imageFromUrl(url:  "https://cdn.idsitnetwork.net/wp-content/uploads/sites/42/2019/01/flower-shop-fields-of-romance-148245.jpg", placeholder: nil)
        ratingView.setRate(rate: product.rate)
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

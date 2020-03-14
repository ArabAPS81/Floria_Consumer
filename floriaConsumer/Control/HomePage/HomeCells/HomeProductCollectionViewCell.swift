//
//  HomeProductCollectionViewCell.swift
//  floriaConsumer
//
//  Created by arabpas on 11/27/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import UIKit
import Kingfisher

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
    @IBOutlet weak var favoriteButton: UIButton!
    var setFavorite:((_ id: Int,_ favorite: Bool)->())?
    var productId: Int!
    
    func cofigure(product: ProductsModel.Product) {
        productId = product.id
        nameLabel.text = product.name
        priceLabel.text = "\(product.price ?? 0)"
        vendorNameLabel.text = product.provider?.name
        imageView.kf.setImage(with: URL.init(string: product.image ?? ""))
        ratingView.setRate(rate: product.rate)
        favoriteButton.isSelected = product.isFavorited
    }
    
    @IBAction func setFavorite(_ sender: UIButton) {
        if setFavorite != nil {
            setFavorite!(productId,sender.isSelected)
        }
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

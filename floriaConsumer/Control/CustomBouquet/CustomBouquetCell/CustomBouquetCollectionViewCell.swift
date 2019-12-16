//
//  CustomBouquetCollectionViewCell.swift
//  floriaConsumer
//
//  Created by arabpas on 12/2/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import UIKit

protocol CustomBouquetCellDelegate: class {
    func addItem(id:Int, count: Int)
}

class CustomBouquetCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "CustomBouquetCollectionViewCell"
    
    static func registerNIBinView(collection: UICollectionView) {
        let nib = UINib.init(nibName: reuseId, bundle: nil)
        collection.register(nib, forCellWithReuseIdentifier: reuseId)
    }
    
    @IBOutlet private weak var shadowedView: UIView!
    @IBOutlet private weak var flowersNumLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    weak var delegate: CustomBouquetCellDelegate?
    private var productId: Int!
    
    private var flowersNum: Int = 0{
        didSet{
            flowersNumLabel.text = "\(flowersNum)"
            
            delegate?.addItem(id: self.productId, count: flowersNum)
        }
    }
    
    func cofigure(product: ProductsModel.Product) {
        nameLabel.text = product.name
        priceLabel.text = product.price
        imageView.imageFromUrl(url:  "https://cdn.idsitnetwork.net/wp-content/uploads/sites/42/2019/01/flower-shop-fields-of-romance-148245.jpg", placeholder: nil)
        productId = product.id
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            self.shadowedView.dropRoundedShadowForAllSides(5)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        shadowedView.layer.cornerRadius = 5
    }
    
    @IBAction private func selectNewFlower(_ sender: UIButton) {
        if flowersNum < 10 {
            flowersNum = flowersNum + 1
        }
    }
    
    @IBAction private func deselectFlower(_ sender: UIButton) {
        if flowersNum > 0 {
            flowersNum = flowersNum - 1
        }
    }
    
}

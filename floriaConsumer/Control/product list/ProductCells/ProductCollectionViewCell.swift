//
//  ProductCollectionViewCell.swift
//  floriaConsumer
//
//  Created by arabpas on 12/1/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "ProductCollectionViewCell"
    
    static func registerNIBinView(collection: UICollectionView) {
        let nib = UINib.init(nibName: reuseId, bundle: nil)
        collection.register(nib, forCellWithReuseIdentifier: reuseId)
    }
    
    
    

    @IBOutlet weak var shadowedView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.shadowedView.dropRoundedShadowForAllSides(5)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        shadowedView.layer.cornerRadius = 5
        
        
    }
    
    
    
}

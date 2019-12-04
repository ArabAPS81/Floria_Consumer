//
//  ExtrasCollectionViewCell.swift
//  floriaConsumer
//
//  Created by arabpas on 12/1/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import UIKit

class ExtrasCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var shadowedView: UIView!
    @IBOutlet weak var selectionButton: UIButton!
    
    static let reuseId = "ExtrasCollectionViewCell"
    
    static func registerNIBinView(collection: UICollectionView) {
        let nib = UINib.init(nibName: reuseId, bundle: nil)
        collection.register(nib, forCellWithReuseIdentifier: reuseId)
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
    
    @IBAction func selectButtonTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }

}

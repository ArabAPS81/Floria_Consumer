//
//  ExtrasCollectionViewCell.swift
//  floriaConsumer
//
//  Created by arabpas on 12/1/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import UIKit

protocol ExtrasCollectionViewCellDelegate: class {
    func deselectPacking(packing: ProductPackingModel.ProductPacking)
    func selectPacking(packing: ProductPackingModel.ProductPacking)
}

class ExtrasCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "ExtrasCollectionViewCell"
    
    static func registerNIBinView(collection: UICollectionView) {
        let nib = UINib.init(nibName: reuseId, bundle: nil)
        collection.register(nib, forCellWithReuseIdentifier: reuseId)
    }

    @IBOutlet weak var shadowedView: UIView!
    @IBOutlet weak var selectionButton: UIButton!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    var productPacking: ProductPackingModel.ProductPacking!
    weak var delegate: ExtrasCollectionViewCellDelegate?
    
    
    func configure(packing:ProductPackingModel.ProductPacking) {
        image.imageFromUrl(url: packing.image, placeholder: #imageLiteral(resourceName: "4039"))
        priceLabel.text = "\(packing.price ?? 0)"
        nameLabel.text = packing.name ?? ""
        self.productPacking = packing
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            self.shadowedView.dropRoundedShadowForAllSides(5)
        }
        selectionButton.isUserInteractionEnabled = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        shadowedView.layer.cornerRadius = 5
    }
    
    @IBAction func selectButtonTapped(_ sender: UIButton) {
    }
    var cellSelected = false
    func setSelected(_ selected: Bool) {
        if cellSelected {
            selectionButton.isSelected = false
            delegate?.deselectPacking(packing: productPacking)
        }else {
            selectionButton.isSelected = true
            delegate?.selectPacking(packing: productPacking)
        }
        cellSelected = !cellSelected
    }
    
    func setDeselected(_ selected: Bool) {
        cellSelected = false
        selectionButton.isSelected = false
        delegate?.deselectPacking(packing: self.productPacking)
    }
    
    

}

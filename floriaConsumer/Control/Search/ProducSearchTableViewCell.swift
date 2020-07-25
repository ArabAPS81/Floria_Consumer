//
//  ProducSearchTableViewCell.swift
//  floriaConsumer
//
//  Created by arabpas on 11/25/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import UIKit

class ProducSearchTableViewCell: UITableViewCell {
    
    static let rowHeight: CGFloat = 93
    
    @IBOutlet weak var shadowedView: UIView!
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productdiscriptionLabel: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var vendorNameLabel: UILabel!
    
    @IBOutlet weak var productImage: UIImageView!
    
    func configure(product: ProductsModel.Product?) {
        productNameLabel.text = product?.name
        productdiscriptionLabel.text = product?.descriptionField ?? ""
        vendorNameLabel.text = product?.provider?.name ?? ""
        
        productImage.kf.setImage(with: URL.init(string: product?.image ?? ""))
        productPrice.text = "\(Int(product?.price ?? 0))LE"
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        let frame = shadowedView.frame
        shadowedView.frame = CGRect.init(x: frame.origin.x, y: frame.origin.y, width: UIScreen.main.bounds.width - 34, height: frame.height)
    }
    
    var shadowAdded = false
    override func layoutSubviews() {
        super.layoutSubviews()
        if !shadowAdded{
            shadowedView.dropRoundedShadowForAllSides(5)
            shadowAdded = true
        }
    }
    
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        selectedBackgroundView = UIView()
    }
    
    

}

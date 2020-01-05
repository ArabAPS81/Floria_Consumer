//
//  ProductTableViewCell.swift
//  floriaConsumer
//
//  Created by Andela on 5/1/20.
//  Copyright © 2020 Obida. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    @IBOutlet weak var shadowedView: UIView!
    @IBOutlet weak var ivProduct: UIImageView!
    @IBOutlet weak var lblProduct: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var rvRating: RateView!
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    static let reuseId = "ProductTableViewCell"
    
    static func registerNIBinView(tableView: UITableView) {
        let nib = UINib.init(nibName: reuseId, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: reuseId)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(product: ProductElement) {
        ivProduct.imageFromUrl(url: product.product.image, placeholder: #imageLiteral(resourceName: "633107Poao80102-1"))
        lblProduct.text = product.product.name
        lblDescription.text = product.product.productDescription
        rvRating.setRate(rate: product.product.rate)
        lblQuantity.text = "\(product.qunatity)"
        lblPrice.text = "\(product.product.price)"
    }
}

//
//  OrderTableViewCell.swift
//  floriaConsumer
//
//  Created by Andela on 1/1/20.
//  Copyright © 2020 Obida. All rights reserved.
//

import UIKit

class OrderTableViewCell: UITableViewCell {

    // MARK: - Properties

    @IBOutlet weak var shadowedView: UIView!
    @IBOutlet weak var ivAvatar: UIImageView!
    @IBOutlet weak var lblOrderNumber: UILabel!
    @IBOutlet weak var lblOrderDate: UILabel!
    @IBOutlet weak var lblOrderPrice: UILabel!
    @IBOutlet weak var lblOrderStatus: UILabel!
    
    
    // MARK: - UITableViewCell

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectedBackgroundView = UIView()
        shadowedView.frame = CGRect.init(x: -100, y: -100, width: 0, height: 0)
    }

    /*override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }*/
    
    // MARK: - Minions

    func configure(order: Order) {
        self.ivAvatar.imageFromUrl(url: order.provider.image, placeholder: #imageLiteral(resourceName: "pro"))
        self.lblOrderNumber.text = "#\(order.id)"
        self.lblOrderDate.text = order.requiredAt
        self.lblOrderPrice.text = ("\(order.total) EGP")
        self.lblOrderStatus.text = order.status.name
    }    
}
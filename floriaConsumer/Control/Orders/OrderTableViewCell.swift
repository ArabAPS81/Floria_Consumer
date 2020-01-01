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

    @IBOutlet weak var ivAvatar: UIImageView!
    @IBOutlet weak var lblOrderNumber: UILabel!
    @IBOutlet weak var lblOrderDate: UILabel!
    @IBOutlet weak var lblOrderPrice: UILabel!
    @IBOutlet weak var lblOrderStatus: UILabel!
    
    
    // MARK: - UITableViewCell

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

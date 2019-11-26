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

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        shadowedView.dropRoundedShadowForAllSides(1)
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}

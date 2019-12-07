//
//  VendorSearchTableViewCell.swift
//  floriaConsumer
//
//  Created by arabpas on 11/26/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import UIKit

class VendorSearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var shadowedView: UIView!
    
    static let rowHeight: CGFloat = 106

    override func awakeFromNib() {
        super.awakeFromNib()
        print(shadowedView.frame)
        print(shadowedView.bounds)
        let frame = shadowedView.frame
        shadowedView.frame = CGRect.init(x: frame.origin.x, y: frame.origin.y, width: UIScreen.main.bounds.width - 34, height: frame.height)
        
    }
    
    var shadowAdded = false
    override func layoutSubviews() {
        super.layoutSubviews()
        if !shadowAdded{
            shadowedView.dropRoundedShadowForAllSides(47)
            shadowAdded = true
        }
    }
    
    override func setNeedsLayout() {
        super.setNeedsLayout()
    }
    
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectedBackgroundView = UIView()

    }

}

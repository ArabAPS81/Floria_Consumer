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
        print("🔴")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print(shadowedView.frame)
        print(shadowedView.bounds)
        shadowedView.dropRoundedShadowForAllSides(47)
        print("🟡")
    }
    
    override func setNeedsLayout() {
        super.setNeedsLayout()
        if let v = shadowedView {
            //v.dropRoundedShadowForAllSides(47)
            print(shadowedView.frame)
            print(shadowedView.bounds)
            print("🟢")
        }
    }
    
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}

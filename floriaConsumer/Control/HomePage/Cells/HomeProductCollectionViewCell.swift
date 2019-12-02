//
//  HomeProductCollectionViewCell.swift
//  floriaConsumer
//
//  Created by arabpas on 11/27/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import UIKit

class HomeProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var shadowedView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.shadowedView.dropRoundedShadowForAllSides(5)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        shadowedView.layer.cornerRadius = 5
        
        
    }
    

}

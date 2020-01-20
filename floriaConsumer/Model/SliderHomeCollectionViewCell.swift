//
//  SliderHomeCollectionViewCell.swift
//  Floria
//
//  Created by macbookpro on 7/15/19.
//  Copyright © 2019 macbookpro. All rights reserved.
//

import UIKit

class SliderHomeCollectionViewCell: UICollectionViewCell
{
    
    @IBOutlet weak var img: UIImageView!
    
    func configure(url: String) {
        img.kf.setImage(with: URL.init(string: url))
    }
}

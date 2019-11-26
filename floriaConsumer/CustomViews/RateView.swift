//
//  RateView.swift
//  floriaConsumer
//
//  Created by arabpas on 11/25/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import UIKit

class RateView: UIStackView {
    
    init(frame: CGRect,rate: Int) {
        super.init(frame: frame)
        commonInit(rate: rate)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        commonInit(rate: 3)
    }
    
    
    private func commonInit(rate: Int) {
        
        for _ in 1...rate {
            self.addArrangedSubview(getStarImage())
        }
        for _ in (rate + 1)...5 {
            self.addArrangedSubview(getDimStarImage())
        }
    }
    
    private func getStarImage() -> UIImageView {
        let imageView = UIImageView.init(image: #imageLiteral(resourceName: "starRate"))
        return imageView
    }
    
    private func getDimStarImage() -> UIImageView {
        let imageView = UIImageView.init(image: #imageLiteral(resourceName: "starRateDim"))
        return imageView
    }
    
    
}

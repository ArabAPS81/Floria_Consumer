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
        setRate(rate: rate)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setRate(rate: 0)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setRate(rate: 0)
    }
    
    func setRate(rate: Int) {
        var rate = rate
        if rate > 5 || rate < 0 {
            rate = 0
        }
        
        reset()
        
        for _ in 0..<rate {
            self.addArrangedSubview(getStarImage())
        }
        for _ in (rate)..<5 {
            self.addArrangedSubview(getDimStarImage())
        }
    }
    
    private func reset() {
        self.arrangedSubviews.forEach { (view) in
            view.removeFromSuperview()
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

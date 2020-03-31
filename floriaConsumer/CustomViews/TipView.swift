//
//  TipView.swift
//  floriaConsumer
//
//  Created by arabpas on 12/16/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import UIKit
import Kingfisher


class TipView: UIView {
    
    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var decorationDesc: UILabel!
    
    static func newInstance(id:Int) -> TipView {
        let view = UINib.init(nibName: "TipView", bundle: nil).instantiate(withOwner: self, options: nil).first as! TipView
        
        switch id {
        case 1:
            let url = URL.init(string:"https://staging.floriaapp.com/uploads/decorationType/0cdd14c211b13a1d36f429cbce69ebb2ec19c7cc.jpg")
            view.carImage.kf.setImage(with: url)
            view.decorationDesc.text = NSLocalizedString("Decorating Lite", comment: "")
        case 2:
            let url = URL.init(string:"https://staging.floriaapp.com/uploads/decorationType/ed817ea6fcf18ce7cddc88abceb0516ec2acad31.jpg")
            view.carImage.kf.setImage(with: url)
            view.decorationDesc.text = NSLocalizedString("Decorating Lauxe", comment: "")
        case 3:
            let url = URL.init(string:"https://staging.floriaapp.com/uploads/decorationType/79d0e6b30ef0244fa1cf3af4ee838e784a2286d4.jpg")
            view.carImage.kf.setImage(with: url)
            view.decorationDesc.text = NSLocalizedString("Decorating Super Lauxe", comment: "")
        default:
            break
        }
        
        
        
        return view
    }
    
    
}

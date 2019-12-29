//
//  CarDecorationReviewController.swift
//  floriaConsumer
//
//  Created by arabpas on 12/8/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import UIKit

class CarDecorationReviewController: UIViewController {
    
    @IBOutlet weak var priceView: UIView?
    @IBOutlet var shadowedView: [UIView]?
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var colorView: UIImageView!
    @IBOutlet weak var carTypeLabel: UILabel!
    @IBOutlet weak var colorNameLabel: UILabel!
    
    var vendor: VendorModel.Vendor!
    
    static func newInstance(vendor: VendorModel.Vendor) -> CarDecorationReviewController {
        let sb = UIStoryboard.init(name: "CarDecoration", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "CarDecorationReviewController") as! CarDecorationReviewController
        vc.vendor = vendor
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        priceView?.layer.borderColor = #colorLiteral(red: 0.9660214782, green: 0.7838416696, blue: 0.1578825712, alpha: 1).cgColor
        shadowedView?.forEach({ (view) in
            view.dropRoundedShadowForAllSides(view.layer.cornerRadius)
        })
    }
    
}

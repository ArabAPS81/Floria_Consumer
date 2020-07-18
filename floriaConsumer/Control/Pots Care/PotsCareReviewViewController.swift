//
//  PotsCareReviewViewController.swift
//  floriaConsumer
//
//  Created by arabpas on 12/9/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import UIKit

class PotsCareReviewViewController: UIViewController {
    
    
    @IBOutlet weak var numOfPotsLabel: UILabel!
    @IBOutlet weak var vendorNameLabel: UILabel!
    
    @IBOutlet weak var vendorAddressLabel: UILabel!
    @IBOutlet weak var potsSizeLabel: UILabel!
    @IBOutlet weak var vendorRating: RateView!
    @IBOutlet weak var vendorImage: UIImageView!
    static func newInstance() -> PotsCareReviewViewController {
        let storyboard = UIStoryboard.init(name: "PotsCare", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PotsCareReviewViewController") as! PotsCareReviewViewController
        return vc
    }
    
    @IBOutlet weak var priceView: UIView?
    @IBOutlet var shadowedView: [UIView]?

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

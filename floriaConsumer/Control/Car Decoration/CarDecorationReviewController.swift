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
    @IBOutlet weak var vendorNameLabel: UILabel!
    @IBOutlet weak var vendorAddressLabel: UILabel!
    @IBOutlet weak var vendorImageLabel: UIImageView!
    @IBOutlet weak var decorationTypeLabel: UILabel!
    
    @IBOutlet weak var decorationTypeImage: UIImageView!
    @IBOutlet weak var carTypeImage: UIImageView!
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
        SubmittOrderQueryModel.submittOrderQueryModel.serviceId = 4
    }
    
    func setupView() {
        priceView?.layer.borderColor = #colorLiteral(red: 0.9660214782, green: 0.7838416696, blue: 0.1578825712, alpha: 1).cgColor
        shadowedView?.forEach({ (view) in
            view.dropRoundedShadowForAllSides(view.layer.cornerRadius)
        })
        let id = (SubmittOrderQueryModel.submittOrderQueryModel.decorationTypeId ?? 1) - 1
        priceLabel.text = "\(vendor.decorationTypes?[id].price ?? 0)"
        colorNameLabel.text = Constants.carColors[SubmittOrderQueryModel.submittOrderQueryModel.colorId! - 1].name
        colorView.backgroundColor = UIColor.init(hexString: Constants.carColors[SubmittOrderQueryModel.submittOrderQueryModel.colorId! - 1].code)
        vendorNameLabel.text = vendor.name
        vendorAddressLabel.text = "\(vendor.address ?? "") \(vendor.district?.name ?? "")"
        vendorImageLabel.imageFromUrl(url: vendor.image, placeholder: nil)
        carTypeLabel.text = Constants.carForId(SubmittOrderQueryModel.submittOrderQueryModel.carTypeId ?? 0).name
//        decorationTypeLabel
//        decorationTypeImage
        carTypeImage.image = Constants.carForId(SubmittOrderQueryModel.submittOrderQueryModel.carTypeId ?? 0).image
        
    }
    
    
    
    
}

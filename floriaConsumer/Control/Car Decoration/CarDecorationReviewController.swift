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
    var vendor: VendorsModel.Vendor!
    
    static func newInstance(vendor: VendorsModel.Vendor) -> CarDecorationReviewController {
        let sb = UIStoryboard.init(name: "CarDecoration", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "CarDecorationReviewController") as! CarDecorationReviewController
        vc.vendor = vendor
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        orderRequest.serviceId = 4
    }
    
    func setupView() {
        priceView?.layer.borderColor = #colorLiteral(red: 0.9660214782, green: 0.7838416696, blue: 0.1578825712, alpha: 1).cgColor
        shadowedView?.forEach({ (view) in
            view.dropRoundedShadowForAllSides(view.layer.cornerRadius)
        })
        let order = orderRequest
        let id = (order.decorationTypeId ?? 1) - 1
        priceLabel.text = "\(vendor.decorationTypes?[safe: id]?.price ?? 0)"
        colorNameLabel.text = Constants.carColors[order.colorId! - 1].name
        colorView.backgroundColor = UIColor.init(hexString: Constants.carColors[order.colorId! - 1].code)
        vendorNameLabel.text = vendor.name
        vendorAddressLabel.text = "\(vendor.address ?? "") \(vendor.district?.name ?? "")"
        vendorImageLabel.imageFromUrl(url: vendor.image, placeholder: nil)
        carTypeLabel.text = Constants.carForId(order.carTypeId ?? 0).name
        decorationTypeLabel.text = Constants.decorationType(id: order.decorationTypeId ?? 1).name
        decorationTypeImage.image = Constants.decorationType(id: order.decorationTypeId ?? 1).image
        carTypeImage.image = Constants.carForId(order.carTypeId ?? 0).image
    }
}
extension Collection {

    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

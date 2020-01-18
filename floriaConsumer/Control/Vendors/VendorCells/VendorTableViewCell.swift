//
//  VindorTableViewCell.swift
//  floriaConsumer
//
//  Created by arabpas on 11/30/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import UIKit

class VendorTableViewCell: UITableViewCell {

   @IBOutlet weak var shadowedView: UIView!
    
    static let rowHeight: CGFloat = 106
    static let reuseId = "VendorTableViewCell"
    
    static func registerNIBinView(tableView: UITableView) {
        let nib = UINib.init(nibName: reuseId, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: reuseId)
    }
    
    @IBOutlet weak var vendorImageView: UIImageView!
    @IBOutlet weak var vendorNameLabel: UILabel!
    @IBOutlet weak var vendorAddressLabel: UILabel!
    @IBOutlet weak var ratingView: RateView!
    
    func cofigure(vendor: VendorsModel.Vendor) {
        vendorNameLabel.text = vendor.name
        vendorAddressLabel.text = vendor.address ?? vendor.district?.name
        vendorImageView.imageFromUrl(url: vendor.image, placeholder: nil)
        ratingView.setRate(rate: vendor.rate)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectedBackgroundView = UIView()
        shadowedView.frame = CGRect.init(x: -100, y: -100, width: 0, height: 0)
        NotificationCenter.default.addObserver(self, selector: #selector(addShadow(_:)), name: NSNotification.Name(rawValue: "addShadow"), object: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    var shadowAdded = false
    @objc func addShadow(_ notification: NSNotification) {
        
        if !shadowAdded{
            shadowedView.dropRoundedShadowForAllSides(47)
            shadowAdded = true
        }
    }
    
}

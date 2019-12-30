//
//  locationcell.swift
//  floriaConsumer
//
//  Created by mac on 12/1/2562 BE.
//  Copyright © 2562 BE Obida. All rights reserved.
//

import UIKit

class AddressTableViewCell: UITableViewCell {

    @IBOutlet weak var shadowedView: UIView!
    @IBOutlet weak var addressIcon: UIImageView!
    
    @IBOutlet weak var buildingLabel: UILabel!
    @IBOutlet weak var phoneNum: UILabel!
    @IBOutlet weak var districtLabel: UILabel!
    @IBOutlet weak var addressNameLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var fullAddressLabel: UILabel!
    
    
    func configure(address: AddressModel.Address) {
        addressNameLabel.text = address.name ?? ""
        buildingLabel.text = "\(address.buildingNumber ?? "")"
        phoneNum.text = address.mobile ?? ""
        districtLabel.text = address.district?.name ?? ""
        notesLabel.text = address.notes ?? ""
        fullAddressLabel.text = address.streetName ?? ""
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        let frame = shadowedView.frame
        shadowedView.frame = CGRect.init(x: frame.origin.x, y: frame.origin.y, width: UIScreen.main.bounds.width - 20, height: frame.height)
        
    }
    
    
    var shadowAdded = false
    override func layoutSubviews() {
        super.layoutSubviews()
        if !shadowAdded{
            shadowedView.dropRoundedShadowForAllSides(5)
            shadowAdded = true
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        selectedBackgroundView = UIView()
        
        if selected {
            shadowedView.backgroundColor = Constants.pincColor
            addressIcon.tintColor = .white
        }else {
            shadowedView.backgroundColor = UIColor.init(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
            addressIcon.tintColor = Constants.pincColor
        }
        
        
    }
}

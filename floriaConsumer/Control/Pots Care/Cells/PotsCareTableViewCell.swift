//
//  PotsCareTableViewCell.swift
//  floriaConsumer
//
//  Created by Symsym on 5/1/20.
//  Copyright © 2020 Obida. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialCards

class PotsCareTableViewCell: UITableViewCell {
    @IBOutlet weak var shadowedView: MDCCard!
    @IBOutlet weak var ivNumberOfPots: UIImageView!
    @IBOutlet weak var lblNumberOfPots: UILabel!
    @IBOutlet weak var ivPotSize: UIImageView!
    @IBOutlet weak var lblPotsSize: UILabel!
    
    static let reuseId = "PotsCareTableViewCell"
    
    static func registerNIBinView(tableView: UITableView) {
        let nib = UINib.init(nibName: reuseId, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: reuseId)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        shadowedView.cornerRadius = 8
        shadowedView.setShadowElevation(ShadowElevation.fabResting, for: .normal)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(potCare: PotCare) {
        lblNumberOfPots.text = "\(potCare.numberOfPots)"
        lblPotsSize.text = potCare.potSize.name
    }
}

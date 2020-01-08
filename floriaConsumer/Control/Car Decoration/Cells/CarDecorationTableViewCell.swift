//
//  CarDecorationTableViewCell.swift
//  floriaConsumer
//
//  Created by Symsym on 5/1/20.
//  Copyright © 2020 Obida. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialCards

class CarDecorationTableViewCell: UITableViewCell {
    @IBOutlet weak var shadowedView: MDCCard!
    @IBOutlet weak var ivDecoration: UIImageView!
    @IBOutlet weak var lblDecoration: UILabel!
    @IBOutlet weak var ivColor: UIImageView!
    @IBOutlet weak var lblColor: UILabel!
    @IBOutlet weak var ivCarType: UIImageView!
    @IBOutlet weak var lblCarType: UILabel!

    static let reuseId = "CarDecorationTableViewCell"
    
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
    
    func configure(decoration: CarDecoration) {
        ivDecoration.imageFromUrl(url: decoration.decoration.image, placeholder: #imageLiteral(resourceName: "carlauxe"))
        lblDecoration.text = decoration.decoration.name
        
        ivColor.backgroundColor = UIColor(hexString: decoration.color.code!)
        lblColor.text = decoration.color.name
        
        ivCarType.imageFromUrl(url: decoration.car.image, placeholder: #imageLiteral(resourceName: "633107Poao80102-1"))
        lblCarType.text = decoration.car.name
    }
}

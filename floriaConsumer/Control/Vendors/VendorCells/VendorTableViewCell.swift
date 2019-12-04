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

    override func awakeFromNib() {
        super.awakeFromNib()
        print(shadowedView.frame)
        print(shadowedView.bounds)
        shadowedView.frame = CGRect.init(x: -100, y: -100, width: 0, height: 0)
        NotificationCenter.default.addObserver(self, selector: #selector(addShadow(_:)), name: NSNotification.Name(rawValue: "addShadow"), object: nil)
    }
    
    @objc func addShadow(_ notification: NSNotification) {
        shadowedView.dropRoundedShadowForAllSides(47)
    }
    
}

//
//  UICollectionselfExtention.swift
//  floriaConsumer
//
//  Created by arabpas on 1/5/20.
//  Copyright © 2020 Obida. All rights reserved.
//

import UIKit

extension UITableView {
    func startLoading() {
        let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        noDataLabel.text          = "No data available"
        noDataLabel.textColor     = UIColor.black
        noDataLabel.textAlignment = .center
        self.backgroundView  = noDataLabel
    }
}

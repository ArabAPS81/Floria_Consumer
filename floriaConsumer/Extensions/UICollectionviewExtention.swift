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
        let activityIndicator: UIActivityIndicatorView  = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        activityIndicator.startAnimating()
        self.backgroundView  = activityIndicator
    }
    
    func stopLoading( _ message: String = "") {
        let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        noDataLabel.text          = message
        noDataLabel.textColor     = UIColor.black
        noDataLabel.textAlignment = .center
        self.backgroundView  = noDataLabel
    }
}

extension UICollectionView {
    func startLoading() {
        let activityIndicator: UIActivityIndicatorView  = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        activityIndicator.startAnimating()
        self.backgroundView  = activityIndicator
    }
    
    func stopLoading( _ message: String = "") {
        let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        noDataLabel.text          = message
        noDataLabel.textColor     = UIColor.black
        noDataLabel.textAlignment = .center
        self.backgroundView  = noDataLabel
    }
}

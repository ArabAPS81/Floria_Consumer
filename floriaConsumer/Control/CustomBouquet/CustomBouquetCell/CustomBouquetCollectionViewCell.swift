//
//  CustomBouquetCollectionViewCell.swift
//  floriaConsumer
//
//  Created by arabpas on 12/2/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import UIKit

class CustomBouquetCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "CustomBouquetCollectionViewCell"
    
    static func registerNIBinView(collection: UICollectionView) {
        let nib = UINib.init(nibName: reuseId, bundle: nil)
        collection.register(nib, forCellWithReuseIdentifier: reuseId)
    }
    
    @IBOutlet weak var shadowedView: UIView!
    @IBOutlet weak var flowersNumLabel: UILabel!
    
    var flowersNum: Int = 0{
        didSet{
            flowersNumLabel.text = "\(flowersNum)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            self.shadowedView.dropRoundedShadowForAllSides(5)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        shadowedView.layer.cornerRadius = 5
    }
    
    @IBAction func selectNewFlower(_ sender: UIButton) {
        flowersNum = flowersNum + 1
    }
    
    @IBAction func deselectFlower(_ sender: UIButton) {
        if flowersNum > 0 {
            flowersNum = flowersNum - 1
        }
    }
    
}

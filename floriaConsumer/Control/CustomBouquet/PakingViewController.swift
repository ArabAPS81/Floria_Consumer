//
//  PakingViewController.swift
//  floriaConsumer
//
//  Created by arabpas on 12/2/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import UIKit

class PakingViewController: UIViewController {
    
    @IBOutlet weak var pakingCollectionView: UICollectionView!
    @IBOutlet weak var baseCollectionView: UICollectionView!
    @IBOutlet weak var cardCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        ExtrasCollectionViewCell.registerNIBinView(collection: pakingCollectionView)
        ExtrasCollectionViewCell.registerNIBinView(collection: baseCollectionView)
        ExtrasCollectionViewCell.registerNIBinView(collection: cardCollectionView)
    }

}

extension PakingViewController: UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 13
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = CGSize.init(width: 130, height: 150)
        return size
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExtrasCollectionViewCell.reuseId, for: indexPath) as! ExtrasCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ExtrasCollectionViewCell {
            cell.setSelected(true)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ExtrasCollectionViewCell {
            cell.setSelected(false)
        }
    }
    
    
}


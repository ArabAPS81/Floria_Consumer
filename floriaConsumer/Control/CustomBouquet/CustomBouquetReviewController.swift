//
//  CustomBouquetReviewController.swift
//  floriaConsumer
//
//  Created by arabpas on 12/2/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import UIKit

class CustomBouquetReviewController: UIViewController {
    
    @IBOutlet weak var priceView: UIView?
    
    @IBOutlet weak var reviewCollectionView: UICollectionView!
    @IBOutlet weak var extrasCollectionView: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        ExtrasCollectionViewCell.registerNIBinView(collection: reviewCollectionView)
        ExtrasCollectionViewCell.registerNIBinView(collection: extrasCollectionView)
        setupView()
    }
    

    func setupView() {
        priceView?.layer.borderColor = #colorLiteral(red: 0.9660214782, green: 0.7838416696, blue: 0.1578825712, alpha: 1).cgColor
    }
}

extension CustomBouquetReviewController: UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case reviewCollectionView:
            return 7
        case extrasCollectionView:
            return 3
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = CGSize.init(width: 130, height: 150)
        return size
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExtrasCollectionViewCell.reuseId, for: indexPath)
        return cell
    }
}

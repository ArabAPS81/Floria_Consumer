//
//  CustomBouquetViewController.swift
//  floriaConsumer
//
//  Created by arabpas on 12/2/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import UIKit

class CustomBouquetViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    static func newInstance() -> CustomBouquetViewController {
        let storyboard = UIStoryboard.init(name: "CustomBouquet", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "CustomBouquetViewController") as! CustomBouquetViewController
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        CustomBouquetCollectionViewCell.registerNIBinView(collection: collectionView)
        (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumLineSpacing = 8
    }

}

extension CustomBouquetViewController: UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 13
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let iphone8SizeWidth: CGFloat = 375
        let iphone8Height: CGFloat = 293
        let iphone8Width: CGFloat = 174
        let scale: CGFloat = UIScreen.main.bounds.width / iphone8SizeWidth
        let size = CGSize.init(width: iphone8Width * scale, height: iphone8Height * scale)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomBouquetCollectionViewCell.reuseId, for: indexPath)
        return cell
    }
    
    
}

//
//  productlist.swift
//  floriaConsumer
//
//  Created by mac on 11/16/2562 BE.
//  Copyright © 2562 BE Obida. All rights reserved.
//

import UIKit

class productlist: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout  {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProductCollectionViewCell.registerNIBinView(collection: collectionView)
    }
  
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.reuseId, for: indexPath) as!  ProductCollectionViewCell
        
        return cell 
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let iphone8SizeWidth: CGFloat = 375
        let iphone8Height: CGFloat = 250
        let iphone8Width: CGFloat = 180
        let scale: CGFloat = UIScreen.main.bounds.width / iphone8SizeWidth
        let size = CGSize.init(width: iphone8Width * scale, height: iphone8Height * scale)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ProductDetails", sender: nil)
    }
    
}

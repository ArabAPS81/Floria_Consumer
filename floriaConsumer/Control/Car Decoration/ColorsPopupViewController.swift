//
//  ColorsPopupViewController.swift
//  floriaConsumer
//
//  Created by arabpas on 12/4/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import UIKit

class ColorsPopupViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumLineSpacing = 8
    }
    
}

extension ColorsPopupViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
   
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 40
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.viewWithTag(100)?.backgroundColor = UIColor.init(red: randomInt()/256.0, green: randomInt()/256.0, blue: randomInt()/256.0, alpha: 1)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.dismiss(animated: true)
    }
    
    func randomInt() -> CGFloat {
        return CGFloat(Int.random(in: 0 ..< 255))
    }
    
  
}

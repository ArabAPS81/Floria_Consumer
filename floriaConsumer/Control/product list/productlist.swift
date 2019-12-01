//
//  productlist.swift
//  floriaConsumer
//
//  Created by mac on 11/16/2562 BE.
//  Copyright © 2562 BE Obida. All rights reserved.
//

import UIKit

class productlist: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProductCollectionViewCell.registerNIBinView(collection: collectionView)
    }
  
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as!  ProductCollectionViewCell
        
        return cell 
    }
    

    @IBAction func go(_ sender: Any) {
        self.performSegue(withIdentifier: "proudct", sender: nil)
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

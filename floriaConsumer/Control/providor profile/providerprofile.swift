//  providerprofile.swift
//  floriaConsumer
//  Created by mac on 11/10/2562 BE.
//  Copyright © 2562 BE Obida. All rights reserved.


import UIKit

class providerprofile: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.reuseId, for: indexPath) as! ProductCollectionViewCell

        return cell
    }
    
    @IBOutlet weak var viewofcells: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        corner(bu: five, by: 10)
        corner(bu: four, by: 10)
        corner(bu: three, by:10)
        corner(bu: two, by: 10)
        corner(bu: one, by: 10)
        ViewAsCell.layer.shadowColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        ViewAsCell.layer.shadowOffset = CGSize(width: 0.1, height: 3.0)
        ViewAsCell.layer.shadowOpacity = 1
        ViewAsCell.layer.cornerRadius = 40
        picofvendor.layer.cornerRadius = 25
        ProductCollectionViewCell.registerNIBinView(collection: viewofcells)
        }
    
    
    @IBOutlet weak var ViewAsCell: UIView!
    @IBOutlet weak var picofvendor: UIImageView!
    @IBOutlet weak var five: UIButton!
    @IBOutlet weak var four: UIButton!
    @IBOutlet weak var three: UIButton!
    @IBOutlet weak var two: UIButton!
    @IBOutlet weak var one: UIButton!
    
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
       }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "prouduct", sender: nil)
    }
 
    
    
    func corner(bu: UIButton , by : Float){
        bu.layer.cornerRadius = CGFloat(by)
    }

    
    

}

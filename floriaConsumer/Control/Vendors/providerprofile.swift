//  providerprofile.swift
//  floriaConsumer
//  Created by mac on 11/10/2562 BE.
//  Copyright © 2562 BE Obida. All rights reserved.


import UIKit

class VendorDetailsViewController: UIViewController{
    var vendor: VendorModel.Vendor!
    
    // MARK: -OUTLETS
    @IBOutlet weak var recentProductCollectionView: UICollectionView!
    @IBOutlet weak var providerCard: UIView!
    @IBOutlet weak var picofvendor: UIImageView!
    @IBOutlet weak var customBoguetBtn: UIButton!
    @IBOutlet weak var readyMadeBtn: UIButton!
    @IBOutlet weak var gerbBtn: UIButton!
    @IBOutlet weak var carDecorationBtn: UIButton!
    @IBOutlet weak var gardeningBtn: UIButton!
    
    // MARK: - BTNs Actions
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewsShapes()
        ProductCollectionViewCell.registerNIBinView(collection: recentProductCollectionView)
    }
    
    func setUpViewsShapes(){
        clipCorners(button: customBoguetBtn, by: 10)
        clipCorners(button: readyMadeBtn, by: 10)
        clipCorners(button: gerbBtn, by:10)
        clipCorners(button: carDecorationBtn, by: 10)
        clipCorners(button: gardeningBtn, by: 10)
        providerCard.layer.shadowColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        providerCard.layer.shadowOffset = CGSize(width: 0.1, height: 3.0)
        providerCard.layer.shadowOpacity = 1
        providerCard.layer.cornerRadius = 40
        picofvendor.layer.cornerRadius = 25
    }
    
    func clipCorners(button: UIButton , by : Float){
        button.layer.cornerRadius = CGFloat(by)
    }
    
    static func newInstance(vendor: VendorModel.Vendor) -> VendorDetailsViewController {
        let storyboard = UIStoryboard.init(name: "Vendor", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "VendorDetailsViewController") as! VendorDetailsViewController
        vc.vendor = vendor
        return vc
    }
}



extension VendorDetailsViewController : UICollectionViewDelegate , UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.reuseId, for: indexPath) as! ProductCollectionViewCell

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "prouduct", sender: nil)
    }
}

//  providerprofile.swift
//  floriaConsumer
//  Created by mac on 11/10/2562 BE.
//  Copyright © 2562 BE Obida. All rights reserved.


import UIKit

protocol VendorDetailsView: class{
    func didReceiveData(data: Codable)
    func didFailToReceiveData(error: Error)
}

class VendorDetailsViewController: UIViewController{
    var vendor: VendorModel.Vendor!
    
    var presenter: VendorDetailsPresenter!
    var vendorProducts = [ProductsModel.Product]()
    
    // MARK: -OUTLETS
    @IBOutlet weak var recentProductCollectionView: UICollectionView!
    @IBOutlet weak var servicesCollectionView: UICollectionView!
    @IBOutlet weak var providerCard: UIView!
    @IBOutlet weak var picofvendor: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var rate: RateView!

    lazy var serviceCollectionDataSource:ServiceCollectionDataSource = ServiceCollectionDataSource(services: vendor.services ?? [])
    // MARK: - BTNs Actions
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
       }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewsShapes()
        ProductCollectionViewCell.registerNIBinView(collection: recentProductCollectionView)
        picofvendor.imageFromUrl(url: vendor.image, placeholder: nil)
        name.text = vendor.name
        address.text = vendor.address
        rate.setRate(rate: vendor.rate)
        
        servicesCollectionView.delegate = serviceCollectionDataSource
        servicesCollectionView.dataSource = serviceCollectionDataSource
        
        let id = vendor.id!
        presenter = VendorDetailsPresenter.init(view: self)
        presenter?.getVendorProducts(vendorId: id )
        //print(vendorProducts)
    }
    
    func setUpViewsShapes(){
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


extension VendorDetailsViewController : UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vendorProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.reuseId, for: indexPath) as! ProductCollectionViewCell
        cell.configure(product: vendorProducts[indexPath.row])
        return cell
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let iphone8SizeWidth: CGFloat = 375
//        let iphone8Height: CGFloat = 250
//        let iphone8Width: CGFloat = 180
//        let scale: CGFloat = UIScreen.main.bounds.width / iphone8SizeWidth
//        let size = CGSize.init(width: iphone8Width * scale, height: iphone8Height * scale)
//        return size
//    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "prouduct", sender: nil)
    }
}

extension VendorDetailsViewController: VendorDetailsView{
    func didReceiveData(data: Codable) {
        if let data = data as? ProductsModel {
            vendorProducts = data.products!
            print(vendorProducts)
            recentProductCollectionView.reloadData()
        }
    }
    func didFailToReceiveData(error: Error) {
        
    }
    
    
}



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
    
    
    static func newInstance(vendorId: Int) -> VendorDetailsViewController {
        let storyboard = UIStoryboard.init(name: "Vendor", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "VendorDetailsViewController") as! VendorDetailsViewController
        vc.vendorId = vendorId
        return vc
    }
    
    var presenter: VendorDetailsPresenter!
    var vendorProducts = [ProductsModel.Product]()
    var vendorId: Int!
    var vendor: VendorsModel.Vendor!
    // MARK: -OUTLETS
    @IBOutlet weak var recentProductCollectionView: UICollectionView!
    @IBOutlet weak var servicesCollectionView: UICollectionView!
    @IBOutlet weak var providerCard: UIView!
    @IBOutlet weak var picofvendor: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var rate: RateView!
    @IBOutlet weak var favoriteButton: UIButton!

    var serviceCollectionDataSource:ServiceCollectionDataSource!
    // MARK: - BTNs Actions
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
       }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewsShapes()
        ProductCollectionViewCell.registerNIBinView(collection: recentProductCollectionView)
        presenter = VendorDetailsPresenter.init(view: self)
        presenter.getVendorDetails(vendorId: vendorId)
        let layout = servicesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.minimumLineSpacing = 0
        layout?.minimumInteritemSpacing = 0
        title = NSLocalizedString("vendor details", comment: "")
    }
    
    @IBAction func setFavoriteButtonTapped(_ sender: UIButton) {

        let service = FavoriteServices.init(delegate: self.presenter)
        if sender.isSelected {
            service.setProviderUnFavorite(self.vendorId)
        }else {
            service.setProviderFavorite(self.vendorId)
        }
    }
    
    func setUpData(vendor: VendorsModel.Vendor) {
        self.vendor = vendor
        name.text = vendor.name
        address.text = vendor.address
        rate.setRate(rate: vendor.rate)
        serviceCollectionDataSource = ServiceCollectionDataSource(services: vendor.services ?? [])
        servicesCollectionView.delegate = serviceCollectionDataSource
        servicesCollectionView.dataSource = serviceCollectionDataSource
        favoriteButton.isSelected = vendor.isFavorited
        let id = vendor.id
        presenter?.getVendorProducts(vendorId: id!)
        picofvendor.imageFromUrl(url: vendor.image, placeholder: nil)
    }
    
    
    
    func setUpViewsShapes(){
        providerCard.layer.shadowColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        providerCard.layer.shadowOffset = CGSize(width: 0.1, height: 3.0)
        providerCard.layer.shadowOpacity = 1
        providerCard.layer.cornerRadius = 50
        picofvendor.layer.cornerRadius = 44
    }
    
    func clipCorners(button: UIButton , by : Float){
        button.layer.cornerRadius = CGFloat(by)
    }
    
    func alertWith(vendor: VendorsModel.Vendor) {
        let alert = UIAlertController.init(title: NSLocalizedString("sorry", comment: ""), message: NSLocalizedString("vendor not available", comment: ""), preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: NSLocalizedString("cancel", comment: ""), style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == recentProductCollectionView {
            let iphone8SizeWidth: CGFloat = 375
            let iphone8Height: CGFloat = 245
            let iphone8Width: CGFloat = 162
            let scale: CGFloat = UIScreen.main.bounds.width / iphone8SizeWidth
            let size = CGSize.init(width: iphone8Width * scale, height: iphone8Height * scale)
            return size
        }
        else {
            return CGSize.init(width: 70, height: 66)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        //self.performSegue(withIdentifier: "prouduct", sender: nil)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if vendor.isOnline ?? false {
            let vc = ProductDetailsViewController.newInstance(product: vendorProducts[indexPath.row])
            self.navigationController?.pushViewController(vc, animated: true)
        }else {
            alertWith(vendor: self.vendor)
        }
    }
}

extension VendorDetailsViewController: VendorDetailsView{
    func didReceiveData(data: Codable) {
        if let model = data as? VendorDetailsModel {
            if let vendor = model.data {
                setUpData(vendor: vendor)
            }
        }
        if let data = data as? ProductsModel {
            vendorProducts = data.products!
            print(vendorProducts)
            recentProductCollectionView.reloadData()
        }
        if let data = data as? FavoriteResponse {
            favoriteButton.isSelected = data.data?.isFavorited ?? false
        }
        
    }
    
    func didFailToReceiveData(error: Error) {
        
    }
}



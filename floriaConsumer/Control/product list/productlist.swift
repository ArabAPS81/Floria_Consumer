//
//  productlist.swift
//  floriaConsumer
//
//  Created by mac on 11/16/2562 BE.
//  Copyright © 2562 BE Obida. All rights reserved.
//

import UIKit

protocol ProductsListView: class {
    func didReceiveData(data: Codable)
    func didFailToReceiveData(error: Error)
}

class ProductListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout  {
    
    
    static func newInstance(listType: ServiceType) -> ProductListViewController {
        let storyboard = UIStoryboard.init(name: "Product", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "ProductListViewController") as! ProductListViewController
        vc.productListType = listType
        return vc
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    var productsList = [ProductsModel.Product]()
    var productListType = ServiceType.readyMade
    var presenter: ProductsListPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HomeProductCollectionViewCell.registerNIBinView(collection: collectionView)
        presenter = ProductsListPresenter.init(view: self)
        presenter?.getVendorProducts(vendor: 1)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addShadow"), object: nil)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeProductCollectionViewCell.reuseId, for: indexPath) as!  HomeProductCollectionViewCell
        cell.cofigure(product: productsList[indexPath.row])
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

extension ProductListViewController: ProductsListView {
    func didReceiveData(data: Codable) {
        if let data = data as? ProductsModel {
            productsList = data.products!
            collectionView.reloadData()
        }
    }
    
    func didFailToReceiveData(error: Error) {
        
    }
    
    
}

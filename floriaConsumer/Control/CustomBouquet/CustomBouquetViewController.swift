//
//  CustomBouquetViewController.swift
//  floriaConsumer
//
//  Created by arabpas on 12/2/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import UIKit

protocol CustomBouquetView: class {
    func didReceiveData(data: Codable)
    func didFailToReceiveData(error: Error)
}

class CustomBouquetViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var serviceType = ServiceType.customBouquet
    var presenter: CustomBouquetPresenter!
    var vendorID: Int!
    
    static func newInstance(vendorID: Int) -> CustomBouquetViewController {
        let storyboard = UIStoryboard.init(name: "CustomBouquet", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "CustomBouquetViewController") as! CustomBouquetViewController
        vc.vendorID = vendorID
        return vc
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        CustomBouquetCollectionViewCell.registerNIBinView(collection: collectionView)
        (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumLineSpacing = 8
        presenter = CustomBouquetPresenter.init(view: self)
        presenter.getVendorProducts(vendorId: vendorID, forService: self.serviceType)
        
    }
    
    @IBAction func selectPackingTapped(_ sender: UIButton){
        presenter.submittOrder()
    }
    
    @IBAction func NextButtonTapped( _ sender: UIButton) {
        if validation() {
            self.performSegue(withIdentifier: "PackingSegue", sender: nil)
        }
    }
    
    func validation() -> Bool {
        if SubmittOrderQueryModel.submittOrderQueryModel.products.isEmpty {
            alertWithMessage("No products selected")
            return false
        }
        return true
    }
    
    func  alertWithMessage(_ message: String) {
        let alert = UIAlertController.init(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}

extension CustomBouquetViewController: UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItemsInSection(section: section)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomBouquetCollectionViewCell.reuseId, for: indexPath) as! CustomBouquetCollectionViewCell
        cell.cofigure(product: presenter.dataForCellAt(indexPath: indexPath))
        cell.delegate = self.presenter
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let iphone8SizeWidth: CGFloat = 375
        let iphone8Height: CGFloat = 293
        let iphone8Width: CGFloat = 174
        let scale: CGFloat = UIScreen.main.bounds.width / iphone8SizeWidth
        let size = CGSize.init(width: iphone8Width * scale, height: iphone8Height * scale)
        return size
    }
}

extension CustomBouquetViewController: CustomBouquetView {
    func didReceiveData(data: Codable) {
        if data is ProductsModel{
            collectionView.reloadData()
        }
    }
    
    func didFailToReceiveData(error: Error) {
        
    }
}

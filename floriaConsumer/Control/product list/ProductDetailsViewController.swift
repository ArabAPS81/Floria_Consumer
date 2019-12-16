//
//  ProductDetailsViewController.swift
//  
//
//  Created by macbookpro on 7/20/19.
//

import UIKit


class ProductDetailsViewController: UIViewController {
    
    @IBOutlet var extrasCollectionView: UICollectionView!
    @IBOutlet var imageSliderCollectioView: UICollectionView!
    @IBOutlet weak var vendorNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    var product: ProductsModel.Product!
    
    var idofpro = ""
    var  x = 1
    
    static func newInstance(product: ProductsModel.Product) -> ProductDetailsViewController {
        let storyboard = UIStoryboard.init(name: "Product", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "ProductDetailsViewController") as! ProductDetailsViewController
        vc.product = product
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        ExtrasCollectionViewCell.registerNIBinView(collection: extrasCollectionView)
        (imageSliderCollectioView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumLineSpacing = 0
    }
    
    func setupViews() {
        vendorNameLabel.text = product.provider?.name ?? ""
        descriptionLabel.text = product.descriptionField
        priceLabel.text = product.price ?? ""
        
    }
    
    @IBAction func minase(_ sender: Any) {
        if x >= 1{
            x-=1
            amountLabel.text = String(x)
        }
    }
    @IBAction func pluss(_ sender: Any) {
        
        x += 1
        amountLabel.text = String(x)
    }
    
}

extension ProductDetailsViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == imageSliderCollectioView {
            return 1
        }
        else{
            return 4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == imageSliderCollectioView {
            self.performSegue(withIdentifier: "zoom", sender: nil)
        }
        
        let alert = UIAlertController(title: "Done", message: "your new item displayed", preferredStyle: UIAlertController.Style.actionSheet)
        
        self.present(alert, animated: true, completion: nil)
        let when = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: when){
            // your code with delay
            alert.dismiss(animated: true, completion: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == imageSliderCollectioView {
            let iphone8SizeWidth: CGFloat = 375
            let iphone8Height: CGFloat = 300
            let iphone8Width: CGFloat = 375
            let scale: CGFloat = UIScreen.main.bounds.width / iphone8SizeWidth
            let size = CGSize.init(width: iphone8Width * scale, height: iphone8Height * scale)
            return size
        }else {
            let size = CGSize.init(width: 120, height: 130)
            return size
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == imageSliderCollectioView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderHome", for: indexPath) as! SliderHomeCollectionViewCell
            cell.configure(url: product.image ?? "")
            return cell;
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExtrasCollectionViewCell.reuseId, for: indexPath) as! ExtrasCollectionViewCell
            return cell
            
        }
        
    }
}



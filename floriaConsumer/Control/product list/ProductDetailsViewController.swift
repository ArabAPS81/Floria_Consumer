//
//  ProductDetailsViewController.swift
//  
//
//  Created by macbookpro on 7/20/19.
//

import UIKit
import Alamofire


class ProductDetailsViewController: UIViewController {
    
    @IBOutlet var extrasCollectionView: UICollectionView!
    @IBOutlet var imageSliderCollectioView: UICollectionView!
    @IBOutlet weak var vendorNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var extrasVIew: UIView!
    
    var product: ProductsModel.Product?
    var extras = [ProductPackingModel.ProductPacking]()
    
    var idofpro = ""
    var  x = 1
    
    static func newInstance(product: ProductsModel.Product?) -> ProductDetailsViewController {
        let storyboard = UIStoryboard.init(name: "Product", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
        vc.product = product
        
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let textAttributes = [NSAttributedString.Key.foregroundColor:Constants.pincColor]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        extrasVIew.isHidden = extras.count == 0
        self.title = product?.name
        setupViews()
        ExtrasCollectionViewCell.registerNIBinView(collection: extrasCollectionView)
        (imageSliderCollectioView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumLineSpacing = 0
        FloriaAppEvents.logViewContentEvent(contentID: "\(product?.id ?? 0)", contentType: product?.service?.name ?? "", currency: "EGP", valueToSum: product?.price ?? 0)
    }
    
    func getProductDetails(id : Int) {
        
    }
    
    func setupViews() {
        vendorNameLabel.text = product?.provider?.name ?? ""
        descriptionLabel.text = product?.descriptionField
        priceLabel.text = "\(product?.price ?? 0)"
        favoriteButton.isSelected = product?.isFavorited ?? false
        let service = VendorServices.init(delegate: self)
        service.getProductExtrasFor(vendor: (product?.provider?.id) ?? 0)
    }
    
    @IBAction func setFavoriteButtonTapped(_ sender: UIButton) {

        let service = FavoriteServices.init(delegate: self)
        if sender.isSelected {
            service.setProductUnFavorite(self.product!.id!)
        }else {
            service.setProductFavorite(self.product!.id!)
            FloriaAppEvents.logAddToWishlistEvent(contentID: "\(product?.id ?? 0)", contentType: product?.service?.name ?? "", currency: "EGP", valueToSum: product?.price ?? 0)
        }
    }
    
    @IBAction func minase(_ sender: Any) {
        if x > 1{
            x-=1
            amountLabel.text = String(x)
        }
    }
    @IBAction func pluss(_ sender: Any) {
        
        x += 1
        amountLabel.text = String(x)
    }
    
    @IBAction func checkOutButtonTapped(_ sender: Any) {
            performSegue(withIdentifier: "checkOutSegue", sender: sender)
        FloriaAppEvents.logInitiateCheckoutEvent(contentID: "\(product?.id ?? 0)", contentType: product?.service?.name ?? "", currency: "EGP", valueToSum: product?.price ?? 0)
       
    }
    
    
    @IBAction func vendorNameTapped(_ sender: Any) {
        
        let vendor = product?.provider
        let vc = VendorDetailsViewController.newInstance(vendorId: vendor?.id ?? 0)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let vc = segue.destination as? viewimg {
            vc.image = product?.image
        }
        
        super.prepare(for: segue, sender: sender)
        let selectedProduct = SubmittOrderQueryModel.OrderProducts.init(id: product?.id ?? 0, quantity: x, price: product?.price ?? 0)
        orderRequest.products = [selectedProduct]
        orderRequest.providerId = product?.provider?.id
        orderRequest.serviceId = product?.service?.id
        
    }
}

extension ProductDetailsViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == imageSliderCollectioView {
            return 1
        }
        else{
            return extras.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == imageSliderCollectioView {
            let iphone8SizeWidth: CGFloat = 375
            let iphone8Height: CGFloat = 375
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
            cell.configure(url: product?.image ?? "")
            return cell;
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExtrasCollectionViewCell.reuseId, for: indexPath) as! ExtrasCollectionViewCell
            cell.configure(packing: extras[indexPath.row])
            cell.delegate = self
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       if collectionView == imageSliderCollectioView {
       // self.performSegue(withIdentifier: "zoom", sender: product?.image)
       }
        if let cell = collectionView.cellForItem(at: indexPath) as? ExtrasCollectionViewCell {
            cell.setSelected(true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
       
        if let cell = collectionView.cellForItem(at: indexPath) as? ExtrasCollectionViewCell {
            cell.setDeselected(true)
        }
    }
}

extension ProductDetailsViewController: WebServiceDelegate {
    func didRecieveData(data: Codable) {
        if let data = data as? ProductPackingModel {
            extras = data.packings ?? []
            extrasCollectionView.reloadData()
        }
        if let data = data as? FavoriteResponse {
            alertWithMessage(data.message, title: nil)
            favoriteButton.isSelected = data.data?.isFavorited ?? false
        }
    }
    
    func didFailToReceiveDataWithError(error: Error) {
        guard let error = error as? AFError else {
            return
        }
        switch error {
        case .invalidURL(let url):
            break
        default:
            break
        }
    }
}

extension ProductDetailsViewController: ExtrasCollectionViewCellDelegate {
    func deselectPacking(packing: ProductPackingModel.ProductPacking) {
        let packingId = packing.id
        orderRequest.extras.removeAll { (item) -> Bool in
            let delete = item.id == packingId
            print("\(item.id)*** \(delete)")
            return delete
        }
    }
    
    func selectPacking(packing: ProductPackingModel.ProductPacking) {
        let packing = SubmittOrderQueryModel.OrderPackings.init(id: packing.id!, quantity: 1, price: packing.price!, packingTypeId: 1)
        orderRequest.extras.append(packing)
    }
}

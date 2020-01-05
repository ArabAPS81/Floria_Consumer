//
//  PakingViewController.swift
//  floriaConsumer
//
//  Created by arabpas on 12/2/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import UIKit

class PakingViewController: UIViewController {
    
    @IBOutlet weak var packingCollectionView: UICollectionView!
    @IBOutlet weak var baseCollectionView: UICollectionView!
    @IBOutlet weak var cardCollectionView: UICollectionView!
    
    var packings = [ProductPackingModel.ProductPacking]()
    var bases = [ProductPackingModel.ProductPacking]()
    var cards = [ProductPackingModel.ProductPacking]()

    override func viewDidLoad() {
        super.viewDidLoad()
        ExtrasCollectionViewCell.registerNIBinView(collection: packingCollectionView)
        ExtrasCollectionViewCell.registerNIBinView(collection: baseCollectionView)
        ExtrasCollectionViewCell.registerNIBinView(collection: cardCollectionView)
        let service = VendorServices.init(delegate: self)
        service.getProductExtrasFor(vendor: 1)
        orderRequest.packings = []
    }
    

}

extension PakingViewController: UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case packingCollectionView: return packings.count
        case baseCollectionView: return bases.count
        case cardCollectionView: return cards.count
        default : return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = CGSize.init(width: 130, height: 150)
        return size
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExtrasCollectionViewCell.reuseId, for: indexPath) as! ExtrasCollectionViewCell
        switch collectionView {
        case packingCollectionView:
            cell.configure(packing: packings[indexPath.row])
        case baseCollectionView:
            cell.configure(packing: bases[indexPath.row])
        case cardCollectionView:
            cell.configure(packing: cards[indexPath.row])
        default : break
        }
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
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

extension PakingViewController: WebServiceDelegate {
    func didRecieveData(data: Codable) {
        packings = ((data as? ProductPackingModel)?.packings ?? []).filter{$0.packingType?.id! == 1 }
        bases = ((data as? ProductPackingModel)?.packings ?? []).filter{$0.packingType?.id! == 2 }
        cards = ((data as? ProductPackingModel)?.packings ?? []).filter{$0.packingType?.id! == 3 }
        packingCollectionView.reloadData()
        baseCollectionView.reloadData()
        cardCollectionView.reloadData()
    }
    
    func didFailToReceiveDataWithError(error: Error) {
        
    }
}

extension PakingViewController: ExtrasCollectionViewCellDelegate {
    func deselectPacking(packing: ProductPackingModel.ProductPacking) {
        let packingId = packing.id
        orderRequest.packings.removeAll { (item) -> Bool in
            let delete = item.id == packingId
            print("\(item.id)*** \(delete)")
            return delete
        }
    }
    
    func selectPacking(packing: ProductPackingModel.ProductPacking) {
        let packing = SubmittOrderQueryModel.OrderPackings.init(id: packing.id!, quantity: 1, price: packing.price!, packingTypeId: 1)
        orderRequest.packings.append(packing)
    }
}


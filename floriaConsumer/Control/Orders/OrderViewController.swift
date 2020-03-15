//
//  OrderViewController.swift
//  floriaConsumer
//
//  Created by Symsym on 31/12/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var svStatus: OrderStatusView!
    @IBOutlet weak var tvOrder: UITableView!
    @IBOutlet weak var rateButton: UIButton!
    
    var order: Order?
    
    enum OrderDetails: Int {
        case vendor = 0, product, carDecoration, potsCare, address, count
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rateButton.isEnabled = (order?.status.id == 5)
        if order?.status.id == 5 {
            rateButton.isEnabled = true
            rateButton.backgroundColor = Constants.pincColor
            rateButton.setTitleColor(.white, for: .normal)
        }
        
        title = "#\(order!.id)"
        
        if (order?.status.id ?? 1) > 4 {
            svStatus.status = 0
        } else {
            svStatus.status = order!.status.id + 1
        }
        
        VendorTableViewCell.registerNIBinView(tableView: self.tvOrder)
        ProductTableViewCell.registerNIBinView(tableView: self.tvOrder)
        CarDecorationTableViewCell.registerNIBinView(tableView: self.tvOrder)
        PotsCareTableViewCell.registerNIBinView(tableView: self.tvOrder)
        AddressTableViewCell.registerNIBinView(tableView: self.tvOrder)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
}

extension OrderViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return OrderDetails.count.rawValue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case OrderDetails.vendor.rawValue: return 1
        case OrderDetails.product.rawValue: return order?.products?.count ?? 0
        case OrderDetails.carDecoration.rawValue: return order?.carDecoration?.count ?? 0
        case OrderDetails.potsCare.rawValue: return order?.potsCare?.count ?? 0
        default: return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case OrderDetails.vendor.rawValue:
            return vendorCell(table: tableView, position: indexPath)
        case OrderDetails.product.rawValue:
            return productCell(table: tableView, position: indexPath)
        case OrderDetails.carDecoration.rawValue:
            return carDecorationCell(table: tableView, position: indexPath)
        case OrderDetails.potsCare.rawValue:
            return potsCareCell(table: tableView, position: indexPath)
        default:
            return addressCell(table: tableView, position: indexPath)
        }
    }
    
    func vendorCell(table: UITableView, position: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: VendorTableViewCell.reuseId, for: position) as! VendorTableViewCell
        
        cell.vendorNameLabel.text = order!.provider.name
        cell.vendorAddressLabel.text = order!.provider.mobile
        cell.vendorImageView.imageFromUrl(url: order!.provider.image, placeholder: #imageLiteral(resourceName: "vendorAvatar"))
        cell.ratingView.setRate(rate: 0)
        
        return cell
    }
    
    func productCell(table: UITableView, position: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: ProductTableViewCell.reuseId, for: position) as! ProductTableViewCell
        
        if let product = order?.products?[position.row] {
            cell.configure(product: product)
        }
        
        return cell
    }

    func carDecorationCell(table: UITableView, position: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: CarDecorationTableViewCell.reuseId, for: position) as! CarDecorationTableViewCell
        
        if let product = order?.carDecoration?[position.row] {
            cell.configure(decoration: product)
        }
        
        return cell
    }

    func potsCareCell(table: UITableView, position: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: PotsCareTableViewCell.reuseId, for: position) as! PotsCareTableViewCell
        
        if let product = order?.potsCare?[position.row] {
            cell.configure(potCare: product)
        }
        
        return cell
    }

    func addressCell(table: UITableView, position: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: AddressTableViewCell.reuseId, for: position) as! AddressTableViewCell
        
        if let address = order?.address?[0] {
            cell.configure(address: address)
        }
        
        return cell
    }
}

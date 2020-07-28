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
    @IBOutlet weak var payButton: UIButton!
    @IBOutlet weak var totalAmontLabel: UILabel!
    
    var order: Order?
    
    enum OrderDetails: Int {
        case vendor = 0, product, carDecoration, potsCare, address, count
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statusChanged(nil)
        NotificationCenter.default.addObserver(self, selector: #selector(statusChanged(_:)), name: NSNotification.Name(rawValue: "orderStatusChanged"), object: nil)
        
        VendorTableViewCell.registerNIBinView(tableView: self.tvOrder)
        ProductTableViewCell.registerNIBinView(tableView: self.tvOrder)
        CarDecorationTableViewCell.registerNIBinView(tableView: self.tvOrder)
        PotsCareTableViewCell.registerNIBinView(tableView: self.tvOrder)
        AddressTableViewCell.registerNIBinView(tableView: self.tvOrder)
    }
    
    @objc func statusChanged(_ notification: NSNotification?) {
        let service = OrdersServices.init(delegate: self)
        service.getOrder(id: order!.id)
    }
    
    func setUpData() {
        if order?.isPaid == 1 {
            payButton.isHidden = false
        }else{
            payButton.isHidden = true
        }
        
        rateButton.isEnabled = (order?.status.id == 5)
        if order?.status.id == 5 {
            rateButton.isEnabled = true
            rateButton.backgroundColor = Constants.pincColor
            rateButton.setTitleColor(.white, for: .normal)
        }
        
        totalAmontLabel.text = NSLocalizedString("The total amount is", comment: "") + " " + String(Int(order!.total)) + " " + NSLocalizedString("EGP", comment: "")
        
        title = "#\(order!.id)"
        
        if (order?.status.id ?? 1) > 4 {
            svStatus.status = 7
        } else {
            svStatus.status = order!.status.id + 1
        }
    }
    
    @IBAction func payFawry(_ sender: UIButton) {
        let service = GeneralServices.init(delegate: self)
        service.payOrder((order?.id)!, paymentNum: "")
    }
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
        cell.favoriteButton.isHidden = true
        
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

extension OrderViewController: WebServiceDelegate {
    
    func didRecieveData(data: Codable) {
        if let data = data as? ComplainModel{
            if data.httpCode == 200{
                alertWithMessage(data.message, title: nil)
                payButton.isHidden = true
            }else{
                alertWithMessage(data.errors?.message?.body?.first ?? NSLocalizedString("error has occured", comment: ""), title: nil)
            }
            
        }else if let data = data as? OrderModel {
            order = data.order
            setUpData()
        }
    }
    
    func didFailToReceiveDataWithError(error: Error) {
        
    }
}

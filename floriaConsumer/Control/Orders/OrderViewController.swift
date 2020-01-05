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
    
    @IBOutlet weak var tvOrder: UITableView!
    
    var order: Order?
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "#\(order!.id)"
        
        VendorTableViewCell.registerNIBinView(tableView: self.tvOrder)
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            return vendorCell(table: tableView, position: indexPath)
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
    
    func fillProductCell() {
    }
    
    func addressCell(table: UITableView, position: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: AddressTableViewCell.reuseId, for: position) as! AddressTableViewCell
        
        if let address = order?.address?[0] {
            cell.configure(address: address)
        }
        
        return cell
    }
}

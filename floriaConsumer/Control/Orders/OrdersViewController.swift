//
//  OrdersViewController.swift
//  floriaConsumer
//
//  Created by Symsym on 31/12/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import UIKit

class OrdersViewController: UIViewController {

    // MARK: - Properties
    
    @IBOutlet weak var tvOrders: UITableView!
    
    var orders: Orders? {
        didSet {
            tvOrders.reloadData()
        }
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        requestOrders()
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: - Minions
    
    func requestOrders() {
        OrdersServices.init(delegate: self)
            .getOrders()
    }
}

extension OrdersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders?.orders.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCustomCell", for: indexPath) as! OrderTableViewCell
        
        if let order = orders?.orders[indexPath.row] {
            cell.lblOrderNumber.text = "#\(order.id)"
            cell.lblOrderDate.text = order.requiredAt
            cell.lblOrderPrice.text = ("\(order.total) EGP")
            cell.lblOrderStatus.text = order.status.name
        }
        
        return cell
    }
    
}

extension OrdersViewController: UITableViewDelegate {
}

extension OrdersViewController: WebServiceDelegate {
    func didRecieveData(data: Codable) {
        if let orders = data as? Orders {
            self.orders = orders
        }
    }
    
    func didFailToReceiveDataWithError(error: Error) {
        print("😱 Orders did fail")
    }
}

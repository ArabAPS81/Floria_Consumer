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
    var selectedOrder: Order? {
        didSet {
            performSegue(withIdentifier: "Segue2Order", sender: self)
        }
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        requestOrders()
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? OrderViewController {
            destination.order = self.selectedOrder
        }
    }
    
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
            cell.configure(order: order)
        }
        
        return cell
    }
    
}

extension OrdersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let order = orders?.orders[indexPath.row] {
            self.selectedOrder = order
        }
    }
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

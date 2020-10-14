//
//  OrdersViewController.swift
//  floriaConsumer
//
//  Created by Symsym on 31/12/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import UIKit

class OrdersViewController: UIViewController {
    
    
    // MARK: - Statics
    static func newInstance() -> OrdersViewController {
        let storyboard = UIStoryboard.init(name: "Orders", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "OrdersViewControllerStoryboard") as! OrdersViewController
        return vc
    }
    
    // MARK: - Properties
    
    @IBOutlet weak var tvOrders: UITableView!
    var meta: Meta!
    var page = 1
    var orders: [Order]? {
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
        title = NSLocalizedString("orders", comment: "")
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        orders = []
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
            .getOrders(page: 1)
    }
}

extension OrdersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCustomCell", for: indexPath) as! OrderTableViewCell
        
        if let order = orders?[safe: indexPath.row] {
            cell.configure(order: order)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItem = (orders?.count)! - 1
        if indexPath.row == lastItem{
            loadMoreData()
        }
        
    }
    
    func loadMoreData(){
        if meta.currentPage < meta.lastPage {
            //tableView.reloadData()
            
            let service = OrdersServices.init(delegate: self)

            service.getOrders(page: meta.currentPage + 1)
            
        }
    }
    
}

extension OrdersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let order = orders?[indexPath.row] {
            self.selectedOrder = order
        }
    }
}

extension OrdersViewController: WebServiceDelegate {
    func didRecieveData(data: Codable) {
        if let orders = data as? Orders {
            if self.orders == nil {
                self.orders = [Order]()
            }
            self.orders!.append(contentsOf: orders.orders)
            self.meta = orders.meta
        }
    }
    
    func didFailToReceiveDataWithError(error: Error) {
        print("😱 Orders did fail")
    }
}

//
//  VendorsListViewController.swift
//  floriaConsumer
//
//  Created by arabpas on 11/30/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import UIKit

class VendorsListViewController: UIViewController {
  
    @IBOutlet weak var tableView: UITableView!
    
    let productsListSegueId = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        VendorTableViewCell.registerNIBinView(tableView: self.tableView)
        self.title = "Select Vendor"
        tableView.separatorStyle = .none
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addShadow"), object: nil)
    }
    
    
}

extension VendorsListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VendorTableViewCell.reuseId) as! VendorTableViewCell
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        performSegue(withIdentifier: "ProductsSegue", sender: nil)
    }
    
    
}

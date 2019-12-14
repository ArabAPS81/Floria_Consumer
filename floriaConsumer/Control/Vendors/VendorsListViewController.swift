//
//  VendorsListViewController.swift
//  floriaConsumer
//
//  Created by arabpas on 11/30/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import UIKit

protocol VendorsListView: class {
    func didReceiveData(data: Codable)
    func didFailToReceiveData(error: Error)
}

class VendorsListViewController: UIViewController {
    
    static func newInstance(service: ServiceType) -> VendorsListViewController {
        let storyboard = UIStoryboard.init(name: "Vendor", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "VendorsListViewController") as! VendorsListViewController
        vc.serviceType = service
        return vc
    }
    
  
    @IBOutlet weak var tableView: UITableView!
    var serviceType: ServiceType!
    var vendorsList = [VendorModel.Vendor]()
    var presenter: VendorListPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        VendorTableViewCell.registerNIBinView(tableView: self.tableView)
        self.title = "Select Vendor"
        tableView.separatorStyle = .none
        presenter = VendorListPresenter.init(view: self)
        presenter?.getVendorsList(serviceType: self.serviceType)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addShadow"), object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addShadow"), object: nil)
    }
    
}

extension VendorsListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vendorsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VendorTableViewCell.reuseId) as! VendorTableViewCell
        cell.cofigure(vendor: vendorsList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        self.navigationController?.pushViewController((serviceType?.associatedViewController())!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 106
    }
    
    
    
}

extension VendorsListViewController: VendorsListView {
    func didReceiveData(data: Codable) {
        if let data = data as? VendorModel {
            vendorsList = data.vendors!
            self.tableView.reloadData()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addShadow"), object: nil)
            }
        }
    }
    
    func didFailToReceiveData(error: Error) {
        
    }
    
    
}

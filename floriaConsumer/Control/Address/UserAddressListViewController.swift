//
//  UserAddressListViewController.swift
//  floriaConsumer
//
//  Created by arabpas on 3/18/20.
//  Copyright © 2020 Obida. All rights reserved.
//

import UIKit

class UserAddressListViewController: UIViewController {
    
    @IBOutlet weak var table: UITableView!
    var addressesList = [AddressModel.Address]()
    
    static func newInstance() -> UserAddressListViewController {
        let storyboard = UIStoryboard.init(name: "Address", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "UserAddressListViewController") as! UserAddressListViewController
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("delivery", comment: "")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let service = AddressService.init(delegate: self)
        service.getListOfAddresses()
        table.startLoading()
    }
    
    @IBAction func addAddressTapped(_ sender: Any) {
        if Defaults().isUserLogged {
        self.performSegue(withIdentifier: "addAddress", sender: nil)
        } else {
            let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
            let nav = storyboard.instantiateInitialViewController() as! UINavigationController
            nav.modalPresentationStyle = .fullScreen
            let vc = nav.viewControllers.first as! LoginViewController
            vc.event = {vc in
                vc.dismiss(animated: true, completion: nil)
            }
            self.present(nav, animated: true, completion: nil)
        }
    }
    
}

extension UserAddressListViewController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addressesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AddressTableViewCell
        cell.configure(address: addressesList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AddAddressViewController.newInstance(fromEdit: true, address: addressesList[indexPath.row])
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension UserAddressListViewController: WebServiceDelegate {
    func didRecieveData(data: Codable) {
        if let data = data as? AddressModel {
            addressesList = data.addresses ?? []
            table.stopLoading()
            table.reloadData()
        }
    }
    
    func didFailToReceiveDataWithError(error: Error) {
        table.stopLoading("No data available")
    }
}

//
//  delivarylist.swift
//  floriaConsumer
//
//  Created by mac on 11/13/2562 BE.
//  Copyright © 2562 BE Obida. All rights reserved.
//

import UIKit

class AddressesListViewController: UIViewController {
    
    @IBOutlet weak var table: UITableView!
    var serviceType: ServiceType = .gerb
    var addressesList = [AddressModel.Address]()
    
    static func newInstance(serviceType: ServiceType) -> AddressesListViewController {
        let storyboard = UIStoryboard.init(name: "Address", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AddressesListViewController") as! AddressesListViewController
        vc.serviceType = serviceType
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("delivery", comment: "")
        if Defaults().isUserLogged {
            
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
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = NSLocalizedString("back", comment: "")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = NSLocalizedString("delivery", comment: "")
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

extension AddressesListViewController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addressesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AddressTableViewCell
        cell.configure(address: addressesList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        orderRequest.addressId = addressesList[indexPath.row].id
        self.navigationController?.pushViewController(serviceType.afterAddressViewController(), animated: true)
    }
}

extension AddressesListViewController: WebServiceDelegate {
    func didRecieveData(data: Codable) {
        if let data = data as? AddressModel {
            addressesList = data.addresses ?? []
            table.stopLoading()
            if addressesList.count == 0 {
                table.stopLoading(NSLocalizedString("No addresses found, Add new Address", comment: ""))
            }
            table.reloadData()
        }
    }
    
    func didFailToReceiveDataWithError(error: Error) {
        table.stopLoading(NSLocalizedString("No addresses found, Add new Address", comment: ""))
    }
}

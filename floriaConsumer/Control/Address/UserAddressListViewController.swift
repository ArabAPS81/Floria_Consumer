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
        let vc = storyboard.instantiateViewController(withIdentifier: "UserAddressListViewController") as! UserAddressListViewController
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
    
    func deleteAddress(id: Int) {
        let service = AddressService.init(delegate: self)
        service.deleteAddress(id: id)
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
        //let vc = AddAddressViewController.newInstance(fromEdit: true, address: addressesList[indexPath.row])
       // self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .normal, title: NSLocalizedString("Delete", comment: "")) { action, index in
            let id = self.addressesList[indexPath.row].id
            self.deleteAddress(id: id)
        }
        delete.backgroundColor = .orange

        let edit = UITableViewRowAction(style: .normal, title: NSLocalizedString("Edit", comment: "")) { action, index in
            let vc = AddAddressViewController.newInstance(fromEdit: true, address: self.addressesList[indexPath.row])
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
        edit.backgroundColor = .lightGray
        
        return [delete, edit]
    }
    
}

extension UserAddressListViewController: WebServiceDelegate {
    func didRecieveData(data: Codable) {
        if let model = data as? AddressModel {
            addressesList = model.addresses ?? []
            table.stopLoading()
            table.reloadData()
        }
        if let model = data as? ComplainModel {
            if model.httpCode == 200 {
                let service = AddressService.init(delegate: self)
                service.getListOfAddresses()
                table.startLoading()
            }
        }
    }
    
    func didFailToReceiveDataWithError(error: Error) {
        table.stopLoading("No data available")
    }
}

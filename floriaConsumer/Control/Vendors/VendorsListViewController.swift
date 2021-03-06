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
        let vc = storyboard.instantiateViewController(withIdentifier: "VendorsListViewController") as! VendorsListViewController
        vc.serviceType = service
        return vc
    }
    
    @IBOutlet weak var tableView: UITableView!
    var serviceType: ServiceType!
    var vendorsList = [VendorsModel.Vendor]()
    var presenter: VendorListPresenter?
    var meta: Meta?
    var filterModel: FilterModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        VendorTableViewCell.registerNIBinView(tableView: self.tableView)
        self.title = NSLocalizedString("Select Vendor", comment: "")
        tableView.separatorStyle = .none
        presenter = VendorListPresenter.init(view: self)
        presenter?.getVendorsList(serviceType: self.serviceType,page: 1)
        tableView.startLoading()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addShadow"), object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addShadow"), object: nil)
    }
    
    func setPlaceHolderLabel(view: UITableView){
        let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height))
        noDataLabel.text          = NSLocalizedString("No data available", comment: "")
        noDataLabel.textColor     = UIColor.black
        noDataLabel.textAlignment = .center
        view.backgroundView  = noDataLabel
    }
    
    @IBAction func order(_ sender: UIButton) {
        
        if sender.isSelected {
            vendorsList = vendorsList.sorted {$0.name!.lowercased() < $1.name!.lowercased()}
        }else{
            vendorsList = vendorsList.sorted {$0.name!.lowercased() > $1.name!.lowercased()}
        }
        tableView.reloadData()
        sender.isSelected = !sender.isSelected
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? FilterViewController {
            vc.delegate = self
        }
    }
    
    func setVendorFavorite(_ favorite: Bool, id:Int) {
        let service = FavoriteServices.init(delegate: self)
        if favorite {
            service.setProviderUnFavorite(id)
        }else {
            service.setProviderFavorite(id)
        }
    }
    
}

extension VendorsListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vendorsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VendorTableViewCell.reuseId) as! VendorTableViewCell
        cell.cofigure(vendor: vendorsList[indexPath.row])
        cell.setFavorite = { id,fav in
            self.setVendorFavorite(fav , id: id)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if vendorsList[indexPath.row].isOnline ?? false {
            tableView.deselectRow(at: indexPath, animated: false)
            if serviceType == ServiceType.carDecoration {
                self.navigationController?.pushViewController(CarDecorationReviewController.newInstance(vendor: vendorsList[indexPath.row]), animated: true)
                orderRequest.providerId = vendorsList[indexPath.row].id ?? 0
            }else {
                orderRequest.providerId = vendorsList[indexPath.row].id ?? 0
                self.navigationController?.pushViewController((serviceType?.associatedViewController(vendorsList[indexPath.row].id))!, animated: true)
            }
        }else {
            alertWith(vendor: vendorsList[indexPath.row])
        }
        
        
        
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItem = vendorsList.count - 1
        if indexPath.row == lastItem{
            loadMoreData()
        }
    }
    
    func loadMoreData(){
        if meta!.currentPage < meta!.lastPage {
            if (filterModel != nil) {
                presenter?.getVendorsList(serviceType: self.serviceType, andFilter: filterModel!, page: meta!.currentPage + 1)
                print("🎉🎉")
            }else{
                presenter?.getVendorsList(serviceType: serviceType,page: meta!.currentPage + 1)
                print("🎉")
            }
            
            
        }
    }
    
    func alertWith(vendor: VendorsModel.Vendor) {
        let alert = UIAlertController.init(title: NSLocalizedString("sorry", comment: ""), message: NSLocalizedString("vendor not available", comment: ""), preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: NSLocalizedString("cancel", comment: ""), style: .cancel, handler: nil))
        alert.addAction(UIAlertAction.init(title: NSLocalizedString("show profile", comment: ""), style: .default, handler: { action in
            self.showVendorProfile(vendor)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showVendorProfile(_ vendor: VendorsModel.Vendor) {
        let vc = VendorDetailsViewController.newInstance(vendorId: vendor.id!)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 106
    }
    
}

extension VendorsListViewController: FilterDelegate {
    func didSelectCity(_ city: Int) {
        filterModel = FilterModel.init(district: city)
        presenter?.getVendorsList(serviceType: self.serviceType, andFilter: filterModel!, page: 1)
    }
    
    
}

extension VendorsListViewController: VendorsListView {
    func didReceiveData(data: Codable) {
        if let data = data as? VendorsModel {
            meta = data.meta
            print("🌷")
            if data.meta?.currentPage != 1{
                vendorsList.append(contentsOf: data.vendors ?? [])
            }else{
                vendorsList = data.vendors ?? []
            }
            
            
            tableView.reloadData()
            if vendorsList.count == 0 {
                tableView.stopLoading("")
            }else {
                self.tableView.reloadData()
                tableView.stopLoading()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addShadow"), object: nil)
            }
        }
    }
    
    func didFailToReceiveData(error: Error) {
        tableView.stopLoading(NSLocalizedString("No data available", comment: ""))
    }
    
}
extension VendorsListViewController : WebServiceDelegate {
    func didRecieveData(data: Codable) {
        if let model = data as? FavoriteResponse {
            alertWithMessage(model.message, title: nil)
            presenter?.getVendorsList(serviceType: self.serviceType,page: meta?.currentPage ?? 1)
        }
    }
    func didFailToReceiveDataWithError(error: Error) {
        
    }
    
    
}

//
//  SearchTableViewController.swift
//  floriaConsumer
//
//  Created by arabpas on 11/24/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class SearchTableViewController: UIViewController {
    
    var fromFavorite: Bool = false
    
    static func newInstance(with tableType: TableType) -> SearchTableViewController {
        
        let storyboard = UIStoryboard.init(name: "Search", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "SearchTableViewController") as! SearchTableViewController
        vc.tableType = tableType
        return vc
    }
    
    enum TableType {
        case vendors,products
        func getName() -> String {
            switch self {
            case .vendors:
                return "Vendors"
            case .products:
                return "Products"
            }
        }
    }
    
    var tableType: TableType = .products
    @IBOutlet weak var tableView: UITableView!
    var productList: [ProductsModel.Product] = []
    var vendorList: [VendorsModel.Vendor] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        VendorTableViewCell.registerNIBinView(tableView: tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if fromFavorite {
            switch tableType {
            case .vendors:
                let service = FavoriteServices.init(delegate: self)
                service.getVendorsFavoriteList()
            case .products:
                let service = FavoriteServices.init(delegate: self)
                service.getProductsFavoriteList()
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addShadow"), object: nil)
    }
    
    func showSearchData(model: SearchProductsQueryModel) {
        var model = model
        model.type = (tableType == TableType.products) ? SearchProductsQueryModel.SearchType.product : SearchProductsQueryModel.SearchType.provider
        let service = ProductService.init(delegate: self)
        service.searchInProducts(model: model)
        tableView.startLoading()
    }
    


}
extension SearchTableViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableType {
        case .products:
            return productList.count
        case .vendors:
            return vendorList.count
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath == tableView.indexPathsForVisibleRows?.last {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addShadow"), object: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch tableType {
        case .products:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProducSearchTableViewCell") as! ProducSearchTableViewCell
            cell.configure(product: productList[indexPath.row])
            return cell
        case .vendors:
            let cell = tableView.dequeueReusableCell(withIdentifier: "VendorSearchTableViewCell") as! VendorSearchTableViewCell
            cell.configure(vendor: vendorList[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableType {
        case .products:
            return ProducSearchTableViewCell.rowHeight
        case .vendors:
            return VendorSearchTableViewCell.rowHeight
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableType {
        case .products:
            let vc = ProductDetailsViewController.newInstance(product: productList[indexPath.row])
            self.navigationController?.pushViewController(vc, animated: true)
        case .vendors:
            let vendor = vendorList[indexPath.row]
            let vc = VendorDetailsViewController.newInstance(vendorId: vendor.id ?? 0)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    
}


extension SearchTableViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        switch tableType {
        case .products:
            let indInfo = IndicatorInfo.init(title: NSLocalizedString("products", comment: ""))
            return indInfo
        case .vendors:
            let indInfo = IndicatorInfo.init(title: NSLocalizedString("vendors", comment: ""))
            return indInfo
        }
    }
}

extension SearchTableViewController: WebServiceDelegate {
    func didRecieveData(data: Codable) {
        if let model = data as? ProductsModel {
            productList = model.products ?? []
            tableView.reloadData()
            tableView.stopLoading((productList.count == 0) ? "no data available" : "")
        }
        if let model = data as? VendorsModel {
            vendorList = model.vendors ?? []
            tableView.reloadData()
            tableView.stopLoading((vendorList.count == 0) ? "no data available" : "")
        }
    }
    
    
}

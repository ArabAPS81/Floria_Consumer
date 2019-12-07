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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        VendorTableViewCell.registerNIBinView(tableView: tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addShadow"), object: nil)
    }
    


}
extension SearchTableViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableType {
        case .products:
            return 5
        case .vendors:
            return 12
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
            
            return cell
        case .vendors:
            let cell = tableView.dequeueReusableCell(withIdentifier: "VendorSearchTableViewCell") as! VendorSearchTableViewCell
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
    
    
}


extension SearchTableViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        switch tableType {
        case .products:
            let indInfo = IndicatorInfo.init(title: "Products")
            return indInfo
        case .vendors:
            let indInfo = IndicatorInfo.init(title: "Vendors")
            return indInfo
        }
    }
    
    
}

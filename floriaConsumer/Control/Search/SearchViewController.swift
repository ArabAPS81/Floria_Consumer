//
//  SearchViewController.swift
//  floriaConsumer
//
//  Created by arabpas on 11/24/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var searchView: UIView!
    
    var searchVC: SearchTableViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        searchView.clipsToBounds = true
        searchView.layer.borderWidth = 2
        searchView.layer.cornerRadius = 17
        searchView.layer.borderColor = #colorLiteral(red: 0.9529411765, green: 0.7450980392, blue: 0.1254901961, alpha: 1)
    }
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        guard let searchText = searchTF.text else {
            alertWithMessage(title: NSLocalizedString("search text can't be empty", comment: ""))
            return
        }
        let searchModel = SearchProductsQueryModel.init(districtId: nil, searchText: searchText, type: SearchProductsQueryModel.SearchType.product)
        searchVC?.showSearchData(model: searchModel)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let vc = segue.destination as? SearchPagerController {
            vc.delegate = self
        }
    }

}

extension SearchViewController: PagerTabStripDelegate {
    
    func updateIndicator(for viewController: PagerTabStripViewController, fromIndex: Int, toIndex: Int) {
        guard let vc = viewController.viewControllers[toIndex] as? SearchTableViewController else {return}
        searchVC = vc
    }
}

extension SearchViewController : UITextFieldDelegate {
    
}

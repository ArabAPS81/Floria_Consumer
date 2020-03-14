//
//  SearchPagerController.swift
//  floriaConsumer
//
//  Created by arabpas on 11/24/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class SearchPagerController: ButtonBarPagerTabStripViewController {
    
    var fromFavorite: Bool = false

    override func viewDidLoad() {
        setup()
        super.viewDidLoad()
    }
    
    func setup() {
        self.settings.style.buttonBarBackgroundColor = .white
        self.settings.style.buttonBarItemBackgroundColor = .white
        self.settings.style.selectedBarHeight = 2
        self.settings.style.buttonBarItemTitleColor = #colorLiteral(red: 0.9692807794, green: 0, blue: 0.4361249506, alpha: 1)
        self.settings.style.selectedBarBackgroundColor = #colorLiteral(red: 0.9529411765, green: 0.7450980392, blue: 0.1254901961, alpha: 1)
        self.settings.style.buttonBarItemLeftRightMargin = 0
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let productsVC = SearchTableViewController.newInstance(with: .products)
        productsVC.fromFavorite = fromFavorite
        let vendorsVC = SearchTableViewController.newInstance(with: .vendors)
        vendorsVC.fromFavorite = fromFavorite
        return [productsVC,vendorsVC]
        
    }
    override func updateIndicator(for viewController: PagerTabStripViewController, fromIndex: Int, toIndex: Int) {
        if delegate is SearchPagerController {
            return
        }
        delegate?.updateIndicator(for: viewController, fromIndex: fromIndex, toIndex: toIndex)
    }
    
    override func updateIndicator(for viewController: PagerTabStripViewController, fromIndex: Int, toIndex: Int, withProgressPercentage progressPercentage: CGFloat, indexWasChanged: Bool) {
        super.updateIndicator(for: viewController, fromIndex: fromIndex, toIndex: toIndex, withProgressPercentage: progressPercentage, indexWasChanged: indexWasChanged)
        delegate?.updateIndicator(for: viewController, fromIndex: fromIndex, toIndex: toIndex)
    }
    
}

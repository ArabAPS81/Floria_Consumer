//
//  FavoritesViewController.swift
//  floriaConsumer
//
//  Created by arabpas on 3/10/20.
//  Copyright © 2020 Obida. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class FavoritesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("favorites", comment: "")
        self.navigationController?.navigationBar.tintColor = .red
        self.navigationController?.navigationBar.barTintColor = .red
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let vc = segue.destination as? SearchPagerController {
            vc.fromFavorite = true
        }
    }

}
extension FavoritesViewController: PagerTabStripDelegate {
    func updateIndicator(for viewController: PagerTabStripViewController, fromIndex: Int, toIndex: Int) {
        
    }
    
    
}

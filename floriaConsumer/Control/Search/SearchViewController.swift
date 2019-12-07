//
//  SearchViewController.swift
//  floriaConsumer
//
//  Created by arabpas on 11/24/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var searchView: UIView!

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

}

//
//  TermsViewController.swift
//  floriaConsumer
//
//  Created by Mariam Elenna on 12/28/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import UIKit

class TermsViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("terms and condition", comment: "")
        label.text = NSLocalizedString("terms and condition content", comment: "")
    }
    


}

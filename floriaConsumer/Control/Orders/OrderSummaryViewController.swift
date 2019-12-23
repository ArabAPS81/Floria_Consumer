//
//  OrderSummaryViewController.swift
//  floriaConsumer
//
//  Created by arabpas on 12/23/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import UIKit

class OrderSummaryViewController: UIViewController {
    
    @IBOutlet weak var subTotalLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var deliveryLabel: UILabel!
    @IBOutlet weak var bankLabel: UILabel!
    @IBOutlet weak var VatLabel: UILabel!
    
    
    
    var summaryModel: OrderSummaryResponceModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        subTotalLabel.text = "\(summaryModel?.summary?.subtotal ?? 0)"
        deliveryLabel.text = "\(summaryModel?.summary?.delivery ?? 0)"
        totalLabel.text = "\(summaryModel?.summary?.total ?? 0)"
        VatLabel.text = "\(summaryModel?.summary?.totalTax ?? 0)"
        bankLabel.text = "\(0.0)"
    }
}



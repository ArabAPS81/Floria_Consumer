//
//  OrderSummaryViewController.swift
//  floriaConsumer
//
//  Created by arabpas on 12/23/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import UIKit

class OrderSummaryViewController: UIViewController {
    
    @IBOutlet weak var promoTF: UITextField!
    @IBOutlet weak var subTotalLabel: UILabel!
    @IBOutlet weak var discountSubTotalLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var deliveryLabel: UILabel!
    @IBOutlet weak var bankLabel: UILabel!
    @IBOutlet weak var VatLabel: UILabel!
    
    
    
    var summaryModel: OrderSummaryResponceModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    func setUpViews() {
        subTotalLabel.text = "\(summaryModel?.summary?.subtotal ?? 0)"
        discountSubTotalLabel.text = "\(summaryModel?.summary?.subTotalAfterDiscount ?? 0)"
        deliveryLabel.text = "\(summaryModel?.summary?.delivery ?? 0)"
        totalLabel.text = "\(summaryModel?.summary?.total ?? 0)"
        VatLabel.text = "\(summaryModel?.summary?.totalTax ?? 0)"
        bankLabel.text = "\(0.0)"
    }
    
    @IBAction func payButtonTapped(_ sender: UIButton) {
        let order = SubmittOrderQueryModel.submittOrderQueryModel
        let service = OrderServices.init(delegate: self)
        service.submitOrder(order: order)
        
    }
    
    func showAlert(_ message: String?) {
        let alert = UIAlertController.init(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertAction.Style.cancel, handler: { (action) in
            self.navigationController?.popToRootViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    @IBAction func addPromoButtonTapped(_ sender: Any) {
        SubmittOrderQueryModel.submittOrderQueryModel.code = promoTF.text
        
        let service = OrderServices.init(delegate: self)
        service.getOrderSummary(order: SubmittOrderQueryModel.submittOrderQueryModel)
    }
}


extension OrderSummaryViewController: WebServiceDelegate {
    func didRecieveData(data: Codable) {
        if let data = data as? OrderSubmittResponseModel {
            if data.httpCode == 201 {
                showAlert("\(data.message ?? "") \(data.data?.id ?? 0)")
            }
        }
        if let data = data as? OrderSummaryResponceModel {
            if data.httpCode == 200 {
                summaryModel = data
                setUpViews()
            }
        }
    }
    
    func didFailToReceiveDataWithError(error: Error) {
    }
}



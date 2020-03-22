//
//  OrderSummaryViewController.swift
//  floriaConsumer
//
//  Created by arabpas on 12/23/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import UIKit
import PKHUD

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
        title = NSLocalizedString("summary", comment: "")
        setUpViews()
    }
    func setUpViews() {
        subTotalLabel.text = "\(summaryModel?.summary?.subtotal ?? 0)"
        discountSubTotalLabel.text = "\(summaryModel?.summary?.subTotalAfterDiscount ?? 0)"
        deliveryLabel.text = "\(summaryModel?.summary?.delivery ?? 0)"
        totalLabel.text = "\(summaryModel?.summary?.total ?? 0)"
        VatLabel.text = "\(summaryModel?.summary?.totalTax ?? 0)"
        bankLabel.text = "\(summaryModel?.summary?.discount ?? 0)"
    }
    
    @IBAction func payButtonTapped(_ sender: UIButton) {
        let order = orderRequest
        let service = OrderServices.init(delegate: self)
        service.submitOrder(order: order)
        
    }
    
    func showAlert(_ message: String?) {
        let alert = UIAlertController.init(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertAction.Style.cancel, handler: { (action) in
            self.navToOrdersVC()
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func navToOrdersVC() {
        let ordersVC = OrdersViewController.newInstance()
        let home = self.navigationController!.viewControllers.first!
        self.navigationController?.setViewControllers([home,ordersVC], animated: true)
    }
    
    @IBAction func addPromoButtonTapped(_ sender: Any) {
        orderRequest.code = promoTF.text
        
        let service = OrderServices.init(delegate: self)
        service.getOrderSummary(order: orderRequest)
        HUD.show(.progress)
    }
    
    func showWebView(urlString: String) {
        let vc = PaymentViewController.init()
        vc.urlString = urlString
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension OrderSummaryViewController: WebServiceDelegate {
    func didRecieveData(data: Codable) {
        
        HUD.hide(animated: true)
        if let data = data as? OrderSubmittResponseModel {
            if data.httpCode == 201 {
                if let urlString = data.responseModel?.paymentUrl {
                    showWebView(urlString: urlString)
                }else {
                    showAlert("\(data.message ?? "") \(data.responseModel?.id ?? 0)")
                }
            }else if data.httpCode == 422 || data.httpCode == 400 {
                promoTF.text = nil
                orderRequest.code = nil
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
        HUD.hide(animated: true)
    }
}



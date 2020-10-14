//
//  OrderSummaryViewController.swift
//  floriaConsumer
//
//  Created by arabpas on 12/23/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import UIKit
import PKHUD
import MyFawryPlugin

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
        subTotalLabel.text = "\(Int(summaryModel?.summary?.subtotal ?? 0))"
        discountSubTotalLabel.text = "\(Int(summaryModel?.summary?.subTotalAfterDiscount ?? 0))"
        deliveryLabel.text = "\(Int(summaryModel?.summary?.delivery ?? 0))"
        totalLabel.text = "\(Int(summaryModel?.summary?.total ?? 0))"
        VatLabel.text = "\(Int(summaryModel?.summary?.totalTax ?? 0))"
        bankLabel.text = "\(Int(summaryModel?.summary?.discount ?? 0))"
    }
    
    @IBAction func payButtonTapped(_ sender: UIButton) {
        sender.isUserInteractionEnabled = false
        let order = orderRequest
        let service = OrderServices.init(delegate: self)
        service.submitOrder(order: order)
        FloriaAppEvents.logPurchaseEvent(contentID: "\(order.products.first?.id ?? 0)", contentType: "\(order.serviceId ?? 0)", currency: "EGP", valueToSum: summaryModel?.summary?.total ?? 0)
        
    }
    
    func fawryPay(orderId: Int,totalPrice: Double){
        
        let FawryPlugin = Fawry.sharedInstance
        
        let user = Defaults().getUser()
        FawryPlugin?.customerEmailAddress = user.email ?? "asd@dfg.hgf"
        FawryPlugin?.customerMobileNumber = user.phone ?? "01100407481"
        FawryPlugin?.skipCustomerInput = true
        
        var itemsList: [Item]!
        itemsList = [Item]()
        itemsList.append(Item.init(productSKU: "\(orderId)", productDescription: "", quantity: 1, price: Double(summaryModel?.summary?.total ?? 0)))
        /*===   Payment  ===*/
        FawryPlugin?.initialize(
            serverURL: "https://atfawry.fawrystaging.com",
            styleParam: nil,
            merchantIDParam: "1tSa6uxz2nT3xBYWrQq7lA==",
            merchantRefNum: "\(orderId)",
            languageParam: NSLocale.current.languageCode!,
            GUIDParam: "#@DDFFEEER",
            customeParameterParam: nil,
            currancyParam: .EGP,
            items: itemsList,
            paymentMethodType: .All)
        
        
        
        FawryPlugin?.showSDK(onViewController: self) { [weak self] (transactionID, statusCode) in
            let service = OrderServices.init(delegate: self)
            if transactionID != nil && statusCode == .TransactionCompleted {
                let ordersVC = OrdersViewController.newInstance()
                let home = self?.navigationController?.viewControllers.first
                self?.navigationController?.setViewControllers([home!,ordersVC], animated: true)
                service.submitOrderSuccess(orderId: orderId)
            }else if statusCode == .UserCancledWithoutReason {
                self?.alertWithMessage(NSLocalizedString("Sorry , Order can'be be Completed as payment is not confirmed", comment: "")) {
                    self?.navigationController?.popToRootViewController(animated: true)
                }
            }else {
                self?.alertWithMessage(NSLocalizedString("Sorry , Order can'be be Completed as payment is not confirmed", comment: "")) {
                    self?.navigationController?.popToRootViewController(animated: true)
                }            }
            
            FawryPlugin?.dispose()
        }
    }
    
    func navToOrdersVC() {
        let ordersVC = OrdersViewController.newInstance()
        let home = self.navigationController!.viewControllers.first!
        self.navigationController?.setViewControllers([home,ordersVC], animated: true)
    }
    
    func showAlert(_ message: String?) {
        let alert = UIAlertController.init(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertAction.Style.cancel, handler: { (action) in
            self.navToOrdersVC()
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func addPromoButtonTapped(_ sender: Any) {
        orderRequest.code = promoTF.text
        
        let service = OrderServices.init(delegate: self)
        service.getOrderSummary(order: orderRequest)
        HUD.show(.progress)
    }
    
    func showWebView(urlString: String,orderId:Int) {
        let vc = PaymentViewController.init()
        vc.orderId = orderId
        vc.urlString = urlString
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    var orderId: String!
}

extension OrderSummaryViewController: WebServiceDelegate {
    func didRecieveData(data: Codable) {
        
        HUD.hide(animated: true)
        if let data = data as? OrderSubmittResponseModel {
            if data.httpCode == 201 {
                if let urlString = data.responseModel?.paymentUrl {
                    fawryPay(orderId: (data.responseModel?.id)!, totalPrice: (summaryModel?.summary?.total)!)
                }else {
                    showAlert("\(data.message ?? "") \(data.responseModel?.id ?? 0)")
                }
            }else if data.httpCode == 422 || data.httpCode == 400 {
                promoTF.text = nil
                orderRequest.code = nil
                alertWithMessage(data.error?.message?.body?.first, title: nil)
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



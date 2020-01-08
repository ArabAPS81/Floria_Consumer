//
//  ShippingViewController.swift
//  floriaConsumer
//
//  Created by mac on 11/13/2562 BE.
//  Copyright © 2562 BE Obida. All rights reserved.
//

import UIKit
import PKHUD

class ShippingViewController: UIViewController {
    
    static func newInstance(serviceType: ServiceType) -> ShippingViewController {
        let storyboard = UIStoryboard.init(name: "Delivery", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "ShippingViewController") as! ShippingViewController
        return vc
    }
    
    @IBOutlet var paymentTypes: [UIButton]!
    @IBOutlet weak var deliveryDateLabel: UILabel!
    @IBOutlet weak var deliveryTimeLabel: UILabel!
    @IBOutlet weak var notesTF: UITextField!
    
    var selectedDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dt = Date.init().addingTimeInterval(75.0 * 60.0)
        setRequiredDate(dt)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func paymentTypeSelected(_ sender: UIButton) {
        for btn in paymentTypes {
            btn.isSelected = false
        }
        sender.isSelected = true
        orderRequest.paymentTypeId = sender.tag
    }
    
    @IBAction func delivaryDateButtonTapped(_ sender: Any) {
        let window = self.view.window
        let dpd = DatePickerDialog.init()
        dpd.locale = Locale.current
        dpd.show("Date Picker", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", defaultDate: selectedDate, minimumDate: Date(), maximumDate: nil, datePickerMode: UIDatePicker.Mode.date, window: window) {
            (date) -> Void in
            if let dt = date {
                self.selectedDate = dt
                self.setRequiredDate(dt)
            }
        }
    }
    
    @IBAction func delivaryTimeButtonTapped(_ sender: Any) {
        
        let window = self.view.window
        let dpd = DatePickerDialog.init()
        dpd.locale = Locale.current
        dpd.show("Time Picker", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", defaultDate: selectedDate, minimumDate: Date(), maximumDate: nil, datePickerMode: UIDatePicker.Mode.time, window: window) {
            (date) -> Void in
            if let dt = date {
                self.selectedDate = dt
                self.setRequiredDate(dt)
            }
        }
    }
    
    @IBAction func shippingButtonTapped(_ sender: Any) {
        let serv = OrderServices.init(delegate: self)
        if validation() {
            serv.getOrderSummary(order: orderRequest)
            HUD.show(.progress)
        }
    }
    
    func setRequiredDate(_ dt: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        self.deliveryTimeLabel.text = formatter.string(from: dt)
        formatter.dateFormat = "yyyy-MM-dd"
        self.deliveryDateLabel.text = formatter.string(from: dt)
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        orderRequest.requiredAt = formatter.string(from: dt)
    }
    
    func validation() -> Bool {
        let order = orderRequest
        if order.requiredAt == nil {
            alertWithMessage("select pick up date")
            return false
        }
        if order.shipping == nil {
            alertWithMessage("")
            orderRequest.shipping = 1
        }
        if order.paymentTypeId == nil {
            alertWithMessage("Select payment method")
            return false
        }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? OrderSummaryViewController{
            vc.summaryModel = sender as? OrderSummaryResponceModel
        }
    }
}

extension ShippingViewController: WebServiceDelegate {
    func didRecieveData(data: Codable) {
        if let data = data as? OrderSummaryResponceModel {
            if data.httpCode == 200 {
                performSegue(withIdentifier: "summary", sender: data)
                HUD.hide(animated: true)
            }else {
                HUD.show(.error)
            }
        }
    }
    
    func didFailToReceiveDataWithError(error: Error) {
        HUD.show(.error)
        print(error.localizedDescription)
    }
    
}

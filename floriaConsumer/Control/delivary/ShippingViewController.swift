//
//  ShippingViewController.swift
//  floriaConsumer
//
//  Created by mac on 11/13/2562 BE.
//  Copyright © 2562 BE Obida. All rights reserved.
//

import UIKit

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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func paymentTypeSelected(_ sender: UIButton) {
        for btn in paymentTypes {
            btn.isSelected = false
        }
        sender.isSelected = true
        SubmittOrderQueryModel.submittOrderQueryModel.paymentTypeId = sender.tag
    }
    
    @IBAction func delivaryDateButtonTapped(_ sender: Any) {
        let window = self.view.window
        let dpd = DatePickerDialog.init()
        dpd.locale = Locale.current
        dpd.show("Date Picker", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", defaultDate: selectedDate, minimumDate: Date(), maximumDate: nil, datePickerMode: UIDatePicker.Mode.date, window: window) {
            (date) -> Void in
            if let dt = date {
                self.selectedDate = dt
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                self.deliveryDateLabel.text = formatter.string(from: dt)
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
                let formatter = DateFormatter()
                formatter.dateFormat = "HH:mm"
                self.deliveryTimeLabel.text = formatter.string(from: dt)
                formatter.dateFormat = "yyyy-MM-dd"
                self.deliveryDateLabel.text = formatter.string(from: dt)
                SubmittOrderQueryModel.submittOrderQueryModel.shipping = 1
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                SubmittOrderQueryModel.submittOrderQueryModel.requiredAt = formatter.string(from: dt)
            }
        }
    }
    @IBAction func shippingButtonTapped(_ sender: Any) {
        let serv = OrderServices.init(delegate: self)
        if validation() {
            serv.getOrderSummary(order: SubmittOrderQueryModel.submittOrderQueryModel)
        }
    }
    
    func validation() -> Bool {
        let order = SubmittOrderQueryModel.submittOrderQueryModel
        if order.requiredAt == nil {
            alertWithMessage("select pick up date")
            return false
        }
        if order.shipping == nil {
            alertWithMessage("")
            return false
        }
        if order.paymentTypeId == nil {
            alertWithMessage("Select payment method")
            return false
        }
        return true
    }
    
    func  alertWithMessage(_ message: String) {
        let alert = UIAlertController.init(title: "", message: message, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction.init(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
           performSegue(withIdentifier: "summary", sender: data)
        }
    }
    
    func didFailToReceiveDataWithError(error: Error) {
        print(error.localizedDescription)
    }
    
    
}

//
//  ShippingViewController.swift
//  floriaConsumer
//
//  Created by mac on 11/13/2562 BE.
//  Copyright © 2562 BE Obida. All rights reserved.
//

import UIKit

class ShippingViewController: UIViewController {
    
    
    @IBOutlet var paymentTypes: [UIButton]!
    
    @IBOutlet weak var deliveryDateButton: UIButton!
    
    @IBOutlet weak var notesTF: UITextField!
    @IBOutlet weak var deliveryTimeButton: UIButton!
    static func newInstance(serviceType: ServiceType) -> ShippingViewController {
        let storyboard = UIStoryboard.init(name: "Delivery", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "ShippingViewController") as! ShippingViewController
        return vc
    }
    
    @IBAction func paymentTypeSelected(_ sender: UIButton) {
        for btn in paymentTypes {
            btn.isSelected = false
        }
        sender.isSelected = true
        SubmittOrderQueryModel.submittOrderQueryModel.paymentTypeId = sender.tag
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func delivaryDateButtonTapped(_ sender: Any) {
        let window = self.view.window
        DatePickerDialog().show("DatePicker", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .date,window: window) {
            (date) -> Void in
            if let dt = date {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-mm-dd HH:mm:ss"
                self.deliveryDateButton.titleLabel?.text = formatter.string(from: dt)
            }
        }
    }
    
    @IBAction func delivaryTimeButtonTapped(_ sender: Any) {
        let window = self.view.window
        DatePickerDialog().show("DatePicker", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .time, window: window) {
            (date) -> Void in
            if let dt = date {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                SubmittOrderQueryModel.submittOrderQueryModel.shipping = 1
                
                SubmittOrderQueryModel.submittOrderQueryModel.serviceId = 2
                SubmittOrderQueryModel.submittOrderQueryModel.requiredAt = formatter.string(from: dt)
                self.deliveryTimeButton.titleLabel?.text = formatter.string(from: dt)
            }
        }
    }
    @IBAction func shippingButtonTapped(_ sender: Any) {
        let serv = OrderServices.init(delegate: self)
        serv.getOrderSummary(order: SubmittOrderQueryModel.submittOrderQueryModel)
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

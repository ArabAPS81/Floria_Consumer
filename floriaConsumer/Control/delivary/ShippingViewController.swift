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
        let vc = storyboard.instantiateViewController(withIdentifier: "ShippingViewController") as! ShippingViewController
        return vc
    }
    
    @IBOutlet var paymentTypes: [UIButton]!
    @IBOutlet weak var deliveryDateLabel: UILabel!
    @IBOutlet weak var deliveryTimeLabel: UILabel!
    @IBOutlet weak var notesTF: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var selectedDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("shipping", comment: "")
        let dt = Date.init().addingTimeInterval(65.0 * 60.0)
        setRequiredDate(dt)
        orderRequest.paymentTypeId = 1 // Visa
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .middle)
    }
    
    @IBAction func delivaryDateButtonTapped(_ sender: Any) {
        let window = self.view.window
        let dpd = DatePickerDialog.init()
        dpd.locale = Locale.init(identifier: "en")
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
        dpd.locale = Locale.init(identifier: "en")
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
            orderRequest.code = nil
            orderRequest.notes = notesTF.text
            serv.getOrderSummary(order: orderRequest)
            HUD.show(.progress)
        }
    }
    
    func setRequiredDate(_ dt: Date) {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "en")
        formatter.dateFormat = "hh:mm a"
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

extension ShippingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell\(indexPath.row + 1)")

           cell?.accessoryType = .none
        if indexPath.row == 0 {
            cell?.accessoryType = .checkmark
        }
        
        if orderRequest.shipping == 2 && indexPath.row == 1 {
            cell?.isUserInteractionEnabled = false
            cell?.isHidden = true
        }
        
        cell?.selectedBackgroundView = UIView()
        return cell ?? UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        orderRequest.paymentTypeId = indexPath.row + 1
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .none
        cell?.setSelected(false, animated: true)
        cell?.accessoryType = .none
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if orderRequest.shipping == 2 && indexPath.row == 1 {
            return 0.0
        }
        return 50
    }
}

extension ShippingViewController: WebServiceDelegate {
    func didRecieveData(data: Codable) {
        if let data = data as? OrderSummaryResponceModel {
            if data.httpCode == 200 {
                performSegue(withIdentifier: "summary", sender: data)
                HUD.flash(.success)
            }else {
                HUD.flash(.error)
                if let msg =  data.error?.message?.body?.first {
                    alertWithMessage(msg, title: nil)
                } else if let msg =  data.error?.message?.packings?.first {
                    alertWithMessage(msg, title: nil)
                }
                
            }
        }else {
            HUD.flash(.error)
        }
    }
    
}
extension WebServiceDelegate {
    func didFailToReceiveDataWithError(error: Error) {
        HUD.flash(.error)
        print(error.localizedDescription)
    }
}

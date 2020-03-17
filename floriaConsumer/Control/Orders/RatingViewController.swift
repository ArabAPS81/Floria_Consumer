//
//  RatingViewController.swift
//  floriaConsumer
//
//  Created by arabpas on 3/15/20.
//  Copyright © 2020 Obida. All rights reserved.
//

import UIKit
import Cosmos

class RatingViewController: UIViewController {
    
    var rate : Double?
    var orderId : Int = 698
    
    static func newInstance(orderID : Int) -> RatingViewController {
        let storyboard = UIStoryboard(name: "Complaints", bundle: nil)
        let rateVC = storyboard.instantiateViewController(withIdentifier: "rateVC") as! RatingViewController
        rateVC.orderId = orderID
        return rateVC
    }
    
    @IBOutlet weak var rateVendorView: CosmosView!
    @IBOutlet weak var rateProductView: CosmosView!
    @IBOutlet weak var commentVendorTF: UITextField!
    @IBOutlet weak var commentProductTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        let screenWidth = self.view.bounds.width
        rateProductView.settings.starSize = Double((screenWidth - 120.0) / 5.0)
        rateProductView.didFinishTouchingCosmos = {rating in
            //self.rate = rating
        }
        rateVendorView.settings.starSize = Double((screenWidth - 120.0) / 5.0)
        rateVendorView.didFinishTouchingCosmos = {rating in
            //self.rate = rating
        }
        title = NSLocalizedString("rating", comment: "")
        
    }
    
    @IBAction func rateTapped(_ sender: Any) {
        if validation() {
            let commentP = commentProductTF.text?.trimmed ?? ""
            let commentV = commentVendorTF.text?.trimmed ?? ""
            let service = OrdersServices.init(delegate: self)
            service.sendRate(orderId: orderId, ratingV: rateVendorView.rating, ratingP: rateProductView.rating, commentV: commentV, commentP: commentP)
        }
    }
    
    func validation() -> Bool{
        if rateProductView.rating <= 2.0 {
            if commentProductTF.text?.isEmpty ?? true{
                alertWithMessage(NSLocalizedString("let us know why product", comment: ""))
                return false
            }
        }
        if rateVendorView.rating <= 2.0 {
            if commentVendorTF.text?.isEmpty ?? true{
                alertWithMessage(NSLocalizedString("let us know why vendor", comment: ""))
                return false
            }
        }
        return true
    }
    
}

extension RatingViewController : WebServiceDelegate{
    func didRecieveData(data: Codable) {
        if let model = data as? RateModel{
            print(model)
            if model.httpCode == 201{
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func didFailToReceiveDataWithError(error: Error) {
        
    }
    
    
}

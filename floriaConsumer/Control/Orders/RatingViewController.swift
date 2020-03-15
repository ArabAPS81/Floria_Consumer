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
    
    @IBOutlet weak var rateView: CosmosView!
    @IBOutlet weak var commentTF: UITextField!
    
    @IBAction func rateTapped(_ sender: Any) {
        let comment = commentTF.text?.trimmed ?? ""
        let service = OrdersServices.init(delegate: self)
        service.sendRate(orderId: orderId, rating: rate ?? 3.0, comment: comment)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        let screenWidth = self.view.bounds.width
        rateView.settings.starSize = Double((screenWidth - 120.0) / 5.0)
        rateView.didFinishTouchingCosmos = {rating in
            self.rate = rating
        }
        title = NSLocalizedString("rating", comment: "")
        
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

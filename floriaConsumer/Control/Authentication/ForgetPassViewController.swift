//
//  ForgetPassVC.swift
//  floriaConsumer
//
//  Created by mac on 12/14/2562 BE.
//  Copyright © 2562 BE Obida. All rights reserved.
//

import UIKit

class ForgetPassViewController: UIViewController {
    
     @IBOutlet weak var mobileTF: UITextField!
     @IBOutlet weak var sendCodeBtn: UIButton!
    
    override func viewDidLoad() {
       super.viewDidLoad()
       setUpViewsShape()
    }
    
    func setUpViewsShape() {
        sendCodeBtn.layer.cornerRadius = 30
        sendCodeBtn.clipsToBounds = true
    }
    
    @IBAction func sendCodeTapped(_ sender: Any) {
       guard let mobile = mobileTF.text?.trimmed , !mobile.isEmpty else {return}
        let service = AuthenticationService.init(delegate: self)
        service.forgetPass(phone: mobile)
    }
}

extension ForgetPassViewController: WebServiceDelegate {
    func didRecieveData(data: Codable) {
        if let model = data as? ForgetPassModel{
            if model.httpCode == 200{
                let vc = ConfirmationCodeViewController.newInstance(comingFromVC: "forgetPass", mobile: model.data?.mobile ?? "")
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
        }
    }
    
    func didFailToReceiveDataWithError(error: Error) {
        
    }
    
    
}

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
    @IBOutlet weak var countryFlagImage: UIImageView!
    var phoneCode: String = "+2"
    
    override func viewDidLoad() {
       super.viewDidLoad()
       setUpViewsShape()
        
        self.title = NSLocalizedString("Forget Password", comment: "")
    }
    
    func setUpViewsShape() {
        sendCodeBtn.layer.cornerRadius = 30
        sendCodeBtn.clipsToBounds = true
    }
    @IBAction func phoneCodeTapped(_ sender: UIButton) {
        let alert = UIAlertController(style: .actionSheet, title: "Phone Codes")
        alert.addLocalePicker(type: .phoneCode) { info in
            self.countryFlagImage.image = info?.flag
            self.phoneCode = info?.phoneCode ?? "+2"
            sender.setTitle(info?.phoneCode, for: .normal)
        }
        alert.addAction(title: NSLocalizedString("ok", comment: ""), style: .cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func sendCodeTapped(_ sender: Any) {
       guard let mobile = mobileTF.text?.trimmed , !mobile.isEmpty else {return}
        let service = AuthenticationService.init(delegate: self)
        service.forgetPass(phone: mobile, countryCode: phoneCode)
    }
}

extension ForgetPassViewController: WebServiceDelegate {
    func didRecieveData(data: Codable) {
        if let model = data as? ForgetPassModel{
            if model.httpCode == 200{
                let vc = ConfirmationCodeViewController.newInstance(comingFromVC: "forgetPass", mobile: String(mobileTF.text?.trimmed ?? ""))
                vc.countryCode = phoneCode
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
        }
    }
    
    func didFailToReceiveDataWithError(error: Error) {
        
    }
    
    
}

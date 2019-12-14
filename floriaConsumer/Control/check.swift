//
//  check.swift
//  floriaConsumer
//
//  Created by mac on 21/02/1441 AH.
//  Copyright © 1441 Obida. All rights reserved.
//

import UIKit

class check: UIViewController {
    override func viewDidLoad() {
        VIEW.layer.cornerRadius = 20
        okkkk.layer.cornerRadius = 10
        vc = LoginService(delegate: self)
    }
    @IBOutlet weak var phon: UITextField!
    @IBOutlet weak var okkkk: UIButton!
    var vc: LoginService!
    @IBOutlet weak var VIEW: UIView!
    @IBAction func ok(_ sender: Any) {
        
        vc.sign(name: phon.text!, email: "", password: "", ext: "verify")
    }
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
       
    }
   
    @IBAction func resend(_ sender: Any) {
        vc.sign(name: phon.text!, email: "", password: "", ext: "resend")

    }
    
   
    
}

extension check: WebServiceDelegate {
    func didRecieveData(data: Codable) {
        
    }
    
    func didFailToReceiveDataWithError(error: Error) {
        
    }
    
    
}

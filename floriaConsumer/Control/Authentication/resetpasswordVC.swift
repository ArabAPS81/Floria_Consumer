//
//  resetpasswordVC.swift
//  floriaConsumer
//
//  Created by mac on 12/14/2562 BE.
//  Copyright © 2562 BE Obida. All rights reserved.
//

import UIKit

class resetpasswordVC: UIViewController {
    
    override func viewDidLoad() {
        
        okkkk.layer.cornerRadius = 20
    }
    @IBOutlet weak var phon: UITextField!
    
    @IBOutlet weak var confirm: UITextField!
    @IBOutlet weak var okkkk: UIButton!
    var vc: resetpasswordAPI!
 
    @IBAction func ok(_ sender: Any) {
        UserDefaults.standard.set(phon.text!, forKey: "mobile")
        vc = resetpasswordAPI(delegate: self)
        let extention = "reset-password/" + UserDefaults.standard.string(forKey: "phone")! 
        vc.sign(pass: phon.text!, confirm: confirm.text!, ext: extention)
    }
   
}

extension resetpasswordVC: WebServiceDelegate {
    func didRecieveData(data: Codable) {
        
    }
    
    func didFailToReceiveDataWithError(error: Error) {
        
    }
    
    
}

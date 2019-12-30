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
 
    @IBAction func ok(_ sender: Any) {
       
    }
   
}

extension resetpasswordVC: WebServiceDelegate {
    func didRecieveData(data: Codable) {
        
    }
    
    func didFailToReceiveDataWithError(error: Error) {
        
    }
    
    
}

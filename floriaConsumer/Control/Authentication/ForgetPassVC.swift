//
//  ForgetPassVC.swift
//  floriaConsumer
//
//  Created by mac on 12/14/2562 BE.
//  Copyright © 2562 BE Obida. All rights reserved.
//

import UIKit

class ForgetPassVC: UIViewController {
     override func viewDidLoad() {
        
                okkkk.layer.cornerRadius = 30
        
        
     }
     @IBOutlet weak var phon: UITextField!
     @IBOutlet weak var okkkk: UIButton!
    
     @IBOutlet weak var VIEW: UIView!
     @IBAction func ok(_ sender: Any) {
         UserDefaults.standard.set(phon.text!, forKey: "mobile")
                
         
     }
     @IBAction func close(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
     }
    

}

extension ForgetPassVC: WebServiceDelegate {
    func didRecieveData(data: Codable) {
        
    }
    
    func didFailToReceiveDataWithError(error: Error) {
        
    }
    
    
}

//
//  resetpasswordVC.swift
//  floriaConsumer
//
//  Created by mac on 12/14/2562 BE.
//  Copyright © 2562 BE Obida. All rights reserved.
//

import UIKit

class NewPassViewController: UIViewController {
    
    
    static func newInstance() -> NewPassViewController {
            let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
            let newPassVC = storyboard.instantiateViewController(withIdentifier: "newPassVC") as! NewPassViewController
            
            return newPassVC
    
        }
    override func viewDidLoad() {
        
        okkkk.layer.cornerRadius = 20
    }
    
    @IBOutlet weak var okkkk: UIButton!
 
    @IBAction func ok(_ sender: Any) {
       
    }
   
}

extension NewPassViewController: WebServiceDelegate {
    func didRecieveData(data: Codable) {
        
    }
    
    func didFailToReceiveDataWithError(error: Error) {
        
    }
    
    
}

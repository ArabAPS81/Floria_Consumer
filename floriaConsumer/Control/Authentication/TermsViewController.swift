//
//  TermsViewController.swift
//  floriaConsumer
//
//  Created by Mariam Elenna on 12/28/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import UIKit

class TermsViewController: UIViewController,WebServiceDelegate {
    
    
    
    @IBOutlet weak var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = ""
        let service = GeneralServices.init(delegate: self)
        service.getGeneralData()
    }
    
    func didRecieveData(data: Codable) {
        if let model = data as? GeneralModel{
            label.text = model.data.termsAndConditions.first?.content ?? ""
        }
    }
    
    func didFailToReceiveDataWithError(error: Error) {
        
    }
    


}

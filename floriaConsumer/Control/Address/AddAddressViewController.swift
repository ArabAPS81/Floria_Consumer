//
//  add-adress.swift
//  floriaConsumer
//
//  Created by mac on 11/14/2562 BE.
//  Copyright © 2562 BE Obida. All rights reserved.
//

import UIKit

class AddAddressViewController: UIViewController {
    
    
    @IBOutlet weak var addressTitleTF: UITextField!
    @IBOutlet weak var streetNameTF: UITextField!
    @IBOutlet weak var buildingNumTF: UITextField!
    @IBOutlet weak var contactNameTF: UITextField!
    @IBOutlet weak var contactPhoneTF: UITextField!
    @IBOutlet weak var notesTF: UITextField!
    @IBOutlet weak var governorateNameButton: UIButton!
    @IBOutlet weak var districtButton: UIButton!
    @IBOutlet weak var onMapLocationButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func addAddressTapped(_ sender: UIButton) {
        var address = SubmittAddressQueryModel.init()
        //address.contactName = "gb"
        address.streetName = "bnabgsdgb"
        address.name = "etenbg"
        address.districtId = 3
        address.phoneNum = "01165454327"
        let service = AddressService.init(delegate: self)
        service.addAddress(address: address)
    }
    
}

extension AddAddressViewController: WebServiceDelegate {
    func didRecieveData(data: Codable) {
        print(data)
        self.dismiss(animated: true, completion: nil)
    }
    
    func didFailToReceiveDataWithError(error: Error) {
        
    }
}

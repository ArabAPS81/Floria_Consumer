//
//  add-adress.swift
//  floriaConsumer
//
//  Created by mac on 11/14/2562 BE.
//  Copyright © 2562 BE Obida. All rights reserved.
//

import UIKit

class AddAddressViewController: UIViewController {
    
    
    static func newInstance(fromEdit: Bool, address: AddressModel.Address? = nil) -> AddAddressViewController {
        let storyboard = UIStoryboard.init(name: "Address", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AddAddressViewController") as! AddAddressViewController
        vc.fromEdit = fromEdit
        vc.address = address
        return vc
    }
    
    var fromEdit: Bool = false
    var address:AddressModel.Address?
    
    @IBOutlet weak var govView: UIView!
    @IBOutlet weak var distView: UIView!
    @IBOutlet weak var addressTitleTF: UITextField!
    @IBOutlet weak var streetNameTF: UITextField!
    @IBOutlet weak var buildingNumTF: UITextField!
    @IBOutlet weak var contactNameTF: UITextField!
    @IBOutlet weak var contactPhoneTF: UITextField!
    @IBOutlet weak var notesTF: UITextField!
    @IBOutlet weak var governorateNameButton: UITextField!
    @IBOutlet weak var districtButton: UITextField!
    @IBOutlet weak var onMapLocationButton: UIButton!
    
    var govPicker = UIPickerView()
    var distPicker = UIPickerView()
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var titlebutton: UIButton!
    
    var govenorate: GovernorateModel.Governorate?{
        didSet{
            districtButton.isEnabled = true
        }
    }
    var district: GovernorateModel.Governorate.District?
    var govs: [GovernorateModel.Governorate] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("Add Address", comment: "")
        setData()
        districtButton.isEnabled = false
        let service = AddressService.init(delegate: self)
        service.getListOfGovs()
        govPicker.delegate = self
        govPicker.dataSource = self
        distPicker.delegate = self
        distPicker.dataSource = self
        governorateNameButton.inputView = govPicker
        districtButton.inputView = distPicker
        contactPhoneTF.keyboardType = .asciiCapableNumberPad
    }
    
    @IBAction func addAddressTapped(_ sender: UIButton) {
        if validation() {
            var address = SubmittAddressQueryModel.init()
            address.streetName = streetNameTF.text
            address.name = addressTitleTF.text
            address.districtId = district?.id
            address.phoneNum = contactPhoneTF.text
            address.buildingNumber = buildingNumTF.text
            address.contactName = contactNameTF.text
            address.notes = notesTF.text
            
            let service = AddressService.init(delegate: self)
            if fromEdit{
                service.editAddress(address: address, id: (self.address?.id)!)
            }else {
                service.addAddress(address: address)
            }
            
        }
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setData() {
        if address != nil {
            streetNameTF.text = address?.streetName
            addressTitleTF.text = address?.name
            self.district = GovernorateModel.Governorate.District()
            self.district?.id = address?.id
            self.district?.name = address?.district?.name
            self.districtButton.text = district?.name
            contactPhoneTF.text = address?.mobile
            contactNameTF.text = address?.contactName
            buildingNumTF.text = address?.buildingNumber
            notesTF.text = address?.notes
            govView.isHidden = true
            distView.isHidden = true
            titlebutton.setTitle(NSLocalizedString("Edit Address", comment: ""), for: .normal)
            saveButton.setTitle(NSLocalizedString("Save", comment: ""), for: .normal)
        }
    }
    
    
    func validation() -> Bool {
        if addressTitleTF.text?.isEmpty ?? false {
            alertWithMessage(title: NSLocalizedString("Set Address Title", comment: ""))
            return false
        }
        if streetNameTF.text?.isEmpty ?? false {
            alertWithMessage(title: NSLocalizedString("Set street name", comment: ""))
            return false
        }
        if buildingNumTF.text?.isEmpty ?? false {
            alertWithMessage(title: NSLocalizedString("Set building number", comment: ""))
            return false
        }
        if contactNameTF.text?.isEmpty ?? false {
            alertWithMessage(title: NSLocalizedString("Set contact name", comment: ""))
            return false
        }
        if contactPhoneTF.text?.isEmpty ?? false {
            alertWithMessage(title: NSLocalizedString("Set contact phone", comment: ""))
            return false
        }
        if govenorate == nil {
            alertWithMessage(title: NSLocalizedString("Choose Governorate", comment: ""))
            return false
        }
        if district == nil {
            alertWithMessage(title: NSLocalizedString("Choose District", comment: ""))
            return false
        }
        return true
    }
}

extension AddAddressViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == govPicker {
            return govs.count
        }
        else {
            return govenorate?.districts?.count ?? 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == govPicker {
            return govs[row].name
        }
        else {
            return govenorate?.districts?[row].name
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == govPicker {
            govenorate = govs[row]
            governorateNameButton.text = govs[row].name
            district = nil
            districtButton.text = nil
        }
        else {
            district = govenorate?.districts?[safe: row]
            districtButton.text = govenorate?.districts?[safe: row]?.name
        }
    }
}

extension AddAddressViewController: WebServiceDelegate {
    func didRecieveData(data: Codable) {
        if let data = data as? AddAddressResponseModel {
            if data.httpCode == 201 || data.httpCode == 200 {
                self.dismiss(animated: true, completion: nil)
                alertWithMessage(title: "Succesfully added")
            }else {
                if let message = data.error?.message?.body?.first {
                    alertWithMessage(title: message)
                }else if let message = data.error?.message?.streetName?.first {
                    alertWithMessage(title: message)
                }else if let message = data.error?.message?.name?.first {
                    alertWithMessage(title: message)
                }else if let message = data.error?.message?.apartmentNumber?.first {
                    alertWithMessage(title: message)
                }else if let message = data.error?.message?.buildingNumber?.first {
                    alertWithMessage(title: message)
                }else if let message = data.error?.message?.mobile?.first {
                    alertWithMessage(title: message)
                }else if let message = data.error?.message?.contactName?.first {
                    alertWithMessage(title: message)
                }
                
            }
        }
        if let data = data as? GovernorateModel {
            govs = data.governorates ?? []
        }
        
    }
    
    func didFailToReceiveDataWithError(error: Error) {
        
    }
}

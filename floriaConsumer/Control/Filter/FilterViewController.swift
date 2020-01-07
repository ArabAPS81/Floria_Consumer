//
//  FilterViewController.swift
//  floriaConsumer
//
//  Created by arabpas on 1/6/20.
//  Copyright © 2020 Obida. All rights reserved.
//

import UIKit

protocol FilterDelegate: class {
    func didSelectCity(_ city: Int)
}

class FilterViewController: UIViewController {
    
    let picker = UIPickerView()
    @IBOutlet weak var locationTF: UITextField!
    var govsList = [GovernorateModel.Governorate]()
    var selectedGov: GovernorateModel.Governorate?
    var selectedDist: GovernorateModel.Governorate.District!
    weak var delegate: FilterDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        picker.dataSource = self
        locationTF.inputView = picker
        let service = AddressService.init(delegate: self)
        service.getListOfGovs()
    }
    
    @IBAction func filterButtonTapped(_ sender: UIButton) {
        if selectedDist != nil {
            delegate?.didSelectCity(selectedDist.id ?? 0)
        }
        self.dismiss(animated: true)
    }

}

extension FilterViewController: WebServiceDelegate {
    func didRecieveData(data: Codable) {
        if let data = data as? GovernorateModel {
            govsList = data.governorates ?? []
        }
        
    }
    
    func didFailToReceiveDataWithError(error: Error) {
        
    }
}

extension FilterViewController: UIPickerViewDelegate,UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return govsList.count
        case 1:
            return selectedGov?.districts?.count ?? 0
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch component {
        case 0:
            return govsList[row].name
        case 1:
            return selectedGov?.districts?[row].name
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 1{
            locationTF.text = selectedGov?.districts?[row].name
            selectedDist = selectedGov?.districts?[row]
        }
        else{
            selectedGov = govsList[row]
            pickerView.reloadComponent(1)
        }
        
    }
}

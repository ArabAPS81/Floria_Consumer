//
//  PotsCareViewController.swift
//  floriaConsumer
//
//  Created by arabpas on 12/9/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import UIKit

class PotsCareViewController: UIViewController {
    
    static func newInstance() -> PotsCareViewController {
        let storyboard = UIStoryboard.init(name: "PotsCare", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "PotsCareViewController") as! PotsCareViewController
        return vc
    }
    
    @IBOutlet weak var numOfPotsTF: UITextField!
    @IBOutlet weak var potSizeTF: UITextField!
    
    var potSizePickerView = UIPickerView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        potSizePickerView.delegate = self
        potSizePickerView.dataSource = self
        let imgView = UIImageView.init(frame: CGRect.init(x: 5, y: 5, width: 35, height: 35))
        imgView.image = UIImage.init(named: "downArrow")
        imgView.contentMode = .scaleAspectFit
        numOfPotsTF.rightView = imgView
        potSizeTF.inputView = potSizePickerView
        orderRequest.serviceId = 5
        
    }
    
    @IBAction func chooseLocationButtonTapped(_ sender: UIButton) {
        if validation() {
            orderRequest.numOfPots = Int(numOfPotsTF.text ?? "1") ?? 1
            let vc = AddressesListViewController.newInstance(serviceType: .potsCare)
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func validation() -> Bool{
        if numOfPotsTF.text!.isEmpty || Int(numOfPotsTF.text ?? "0") ?? 0 <= 0 {
            alertWithMessage("Number of pots is requires")
            return false
        }
        if potSizeTF.text!.isEmpty {
            alertWithMessage("Select pots size")
            return false
        }
        return true
    }
}

extension PotsCareViewController:UIPickerViewDelegate,UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Constants.potsSizes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Constants.potsSizes[row].1
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        potSizeTF.text = Constants.potsSizes[row].1
        orderRequest.potSizeId = Constants.potsSizes[row].0
    }
    
}

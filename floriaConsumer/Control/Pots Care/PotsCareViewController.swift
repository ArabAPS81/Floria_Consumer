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
    @IBOutlet weak var dateTF: UITextField!
    @IBOutlet weak var timeTF: UITextField!
    
    var potSizePickerView = UIPickerView()
    
    private var potsSizes = [(1,"Less than 12.5 square meters"),(2,"Between 12.5 to 16 square meters"),(3,"Greater than 16 square meters")]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        potSizePickerView.delegate = self
        potSizePickerView.dataSource = self
        let imgView = UIImageView.init(frame: CGRect.init(x: 5, y: 5, width: 35, height: 35))
        imgView.image = UIImage.init(named: "downArrow")
        imgView.contentMode = .scaleAspectFit
        numOfPotsTF.rightView = imgView
        potSizeTF.inputView = potSizePickerView
        
    }
    
    @IBAction func chooseLocationButtonTapped(_ sender: UIButton) {
        let vc = AddressesListViewController.newInstance(serviceType: .potsCare)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}

extension PotsCareViewController:UIPickerViewDelegate,UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return potsSizes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return potsSizes[row].1
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        potSizeTF.text = potsSizes[row].1
        SubmittOrderQueryModel.submittOrderQueryModel.potSizeId = potsSizes[row].0
    }
    
}

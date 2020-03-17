//
//  SupportViewController.swift
//  floriaConsumer
//
//  Created by arabpas on 3/16/20.
//  Copyright © 2020 Obida. All rights reserved.
//

import UIKit

class SupportViewController: UIViewController {
    
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var helpTV: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("help and support", comment: "")

        titleTF.layer.cornerRadius = 5
        titleTF.layer.borderWidth = 0.5
        titleTF.layer.borderColor = Constants.pincColor.cgColor
        
        helpTV.layer.cornerRadius = 5
        helpTV.layer.borderWidth = 0.5
        helpTV.layer.borderColor = Constants.pincColor.cgColor
    }
    
    @IBAction func submittButtonTapped() {
        if validation() {
            let service = GeneralServices.init(delegate: self)
            service.submittSupportMessage(helpTV.text, title: titleTF.text!)
        }
    }
    
    func validation() -> Bool{
        guard let _ = titleTF.text, !titleTF.text!.isEmpty else{
            alertWithMessage(NSLocalizedString("title is empty", comment: ""))
            return false
        }
        guard let _ = helpTV.text, !helpTV.text!.isEmpty else{
            alertWithMessage(NSLocalizedString("content is empty", comment: ""))
            return false
        }
        return true
    }
    
    func successAlert() {
        let alert = UIAlertController.init(title: NSLocalizedString("sorry", comment: ""), message: NSLocalizedString("vendor not available", comment: ""), preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: NSLocalizedString("ok", comment: ""), style: .cancel, handler: {
            action in
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

extension SupportViewController: WebServiceDelegate {
    func didRecieveData(data: Codable) {
        if let model = data as? ComplainModel {
            if model.httpCode == 200 || model.httpCode == 201 {
                successAlert()
            }
        }
    }
    func didFailToReceiveDataWithError(error: Error) {
        print(error.localizedDescription)
    }
    
    
}

//
//  SupportViewController.swift
//  floriaConsumer
//
//  Created by arabpas on 3/16/20.
//  Copyright © 2020 Obida. All rights reserved.
//

import UIKit

class SupportViewController: UIViewController {
    
    @IBOutlet weak var selectedImage: UIImageView!
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var helpTV: UITextView!
    var imageData: Data?

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
            service.submittSupportMessageWithFile(helpTV.text, title: titleTF.text!,image: imageData)
        }
    }
    
    @IBAction func choosePhoto(_ sender: Any) {
        let actionSheet = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction.init(title: NSLocalizedString("Camera", comment: ""), style: .default, handler: { (_) in
            self.OpenCam()
        }))
        actionSheet.addAction(UIAlertAction.init(title: NSLocalizedString("PhotoLibrary", comment: ""), style: .default, handler: { (_) in
            self.openLibrary()
        }))
        actionSheet.addAction(UIAlertAction.init(title: NSLocalizedString("cancel", comment: ""), style: .cancel, handler: nil))
        self.present(actionSheet, animated: true)
    }
    
    func OpenCam(){
        let imagePicker = UIImagePickerController.init()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true)
    }
    func openLibrary() {
        let imagePicker = UIImagePickerController.init()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true)
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
        let alert = UIAlertController.init(title: nil, message: NSLocalizedString("Complaint Submitted succefully", comment: ""), preferredStyle: .alert)
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

extension SupportViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.editedImage]as? UIImage
        selectedImage.image = image
        imageData = image?.jpegData(compressionQuality: 0.9) ?? Data()
        picker.dismiss(animated: true)
    }
}

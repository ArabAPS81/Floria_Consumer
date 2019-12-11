//
//  CustomAlert.swift
//  floriaConsumer
//
//  Created by mac on 12/11/2562 BE.
//  Copyright © 2562 BE Obida. All rights reserved.
//

import UIKit

class CustomAlert: NSObject {
    func alertt(header:String,body:String, view : UIViewController ) {
                    let alert = UIAlertController(title: header, message: body , preferredStyle: UIAlertController.Style.actionSheet)
                                      
                                      view.present(alert, animated: true, completion: nil)
                                  let when = DispatchTime.now() + 2
                                  DispatchQueue.main.asyncAfter(deadline: when){
                                    // your code with delay
                                    alert.dismiss(animated: true, completion: nil)
                                  }
    }
}

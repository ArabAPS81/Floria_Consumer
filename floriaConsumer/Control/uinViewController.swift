//
//  uinViewController.swift
//  floriaConsumer
//
//  Created by mac on 15/02/1441 AH.
//  Copyright © 1441 Obida. All rights reserved.
//

import UIKit

class uinViewController: UINavigationController {

     open override var childForStatusBarHidden: UIViewController? {
           return self.topViewController
       }

       open override var childForStatusBarStyle: UIViewController? {
           return self.topViewController
       }
}

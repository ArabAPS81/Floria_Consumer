//
//  viewimg.swift
//  floriaConsumer
//
//  Created by mac on 22/02/1441 AH.
//  Copyright © 1441 Obida. All rights reserved.
//

import UIKit
import Kingfisher
class viewimg: UIViewController {
    var image: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        backimg.imageFromUrl(url: image, placeholder: nil)
        
    }
    @IBOutlet weak var backimg: UIImageView!
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}

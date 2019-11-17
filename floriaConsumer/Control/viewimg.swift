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

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = NSURL(string:UserDefaults.standard.string(forKey: "pic")!)
    
self.backimg.kf.setImage(with: url as! URL)
        
    }
    @IBOutlet weak var backimg: UIImageView!
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

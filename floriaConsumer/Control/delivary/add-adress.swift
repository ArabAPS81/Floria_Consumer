//
//  add-adress.swift
//  floriaConsumer
//
//  Created by mac on 11/14/2562 BE.
//  Copyright © 2562 BE Obida. All rights reserved.
//

import UIKit

class add_adress: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if UserDefaults.standard.string(forKey: "send") == "car"{
            maintitel.text = "car decoration "
        }else {
           maintitel.text = "add location"
        }
    }
  
    @IBOutlet weak var maintitel: UILabel!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func back(_ sender: Any) {
           self.dismiss(animated: true, completion: nil)
       }


}

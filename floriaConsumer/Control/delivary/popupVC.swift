//
//  popupVC.swift
//  floriaConsumer
//
//  Created by mac on 12/1/2562 BE.
//  Copyright © 2562 BE Obida. All rights reserved.
//

import UIKit

class popupVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    let arr = ["cairo ", "Alex ", "mansoura "]
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = arr[indexPath.row]

             return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        customalert(header: "Done ", body: arr[indexPath.row]+"Selected ")
       
    }
    func customalert(header:String , body : String){
        let alert = UIAlertController(title: header, message: body , preferredStyle: UIAlertController.Style.actionSheet)
                        
                        self.present(alert, animated: true, completion: nil)
                    let when = DispatchTime.now() + 2
                    DispatchQueue.main.asyncAfter(deadline: when){
                      // your code with delay
                      alert.dismiss(animated: true, completion: nil)
                        self.dismiss(animated: true, completion: nil)
                    }
    }

}

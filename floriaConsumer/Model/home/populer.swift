
//  populer.swift
//  Floria
//
//  Created by obada on 8/29/19.
//  Copyright © 2019 macbookpro. All rights reserved.
//

import UIKit
 import SwiftyJSON
class populer: NSObject {
    var titel : String
    var ratee :Int
    var price : Int
    var id : Int
    var img : String
    
        init?(dict: [String : JSON]) {
            guard  let name = dict["name_eng"]?.string, let priceofitem = dict["price"]?.int,let idofitem = dict["id"]?.int,
                let id = dict["rate"]!.int,let imag = dict["img"]!.string else {
                    print("from model")
                    return nil
            }
            self.titel = name
            self.price = priceofitem
            self.ratee = id
            self.id = idofitem
            self.img = imag
        }
    }
/*"img" : [
{
  "img_path" : "images\/product_img\/f5.png"
}*/

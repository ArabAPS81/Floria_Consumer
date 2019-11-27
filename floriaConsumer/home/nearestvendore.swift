//
//  nearestvendore.swift
//  floriaConsumer
//
//  Created by mac on 11/19/2562 BE.
//  Copyright © 2562 BE Obida. All rights reserved.
//

import UIKit
import SwiftyJSON
class nearestvendore: NSObject {
    var titel : String
    var erea : String
    var id : String
   
    
        init?(dict: [String : JSON]) {
            guard  let name = dict["name_eng"]?.string, let location = dict["Area"]?.string,let idof = dict["id"]?.string else {
                    print("from model")
                    return nil
            }
            self.titel = name
            self.erea = location
           
            self.id = idof
            
        }
    }


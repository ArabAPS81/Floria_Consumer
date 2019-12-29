//
//  Constants.swift
//  floriaConsumer
//
//  Created by arabpas on 12/3/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import UIKit



class Constants {
    static let pincColor = #colorLiteral(red: 0.9692807794, green: 0, blue: 0.4361249506, alpha: 1)
    static let yellowColor = #colorLiteral(red: 0.9660214782, green: 0.7838416696, blue: 0.1578825712, alpha: 1)
    static let grayColor = UIColor.darkGray
    
    
    static let carColors = [CarColors.init(id: 1, name: "White", code: "FFFFFF"),
              CarColors.init(id: 2, name: "Black", code: "000000"),
              CarColors.init(id: 3, name: "Red", code: "FF0000"),
              CarColors.init(id: 4, name: "Yellow", code: "FFFF00"),
              CarColors.init(id: 5, name: "Green", code: "008000"),
              CarColors.init(id: 6, name: "Blue", code: "0000FF"),
    ]
}

struct CarColors {
    var id: Int
    var name: String
    var code : String
}

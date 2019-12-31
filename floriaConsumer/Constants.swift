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
    
    
    static let carColors = [CarColor.init(id: 1, name: "White", code: "FFFFFF"),
              CarColor.init(id: 2, name: "Black", code: "000000"),
              CarColor.init(id: 3, name: "Red", code: "FF0000"),
              CarColor.init(id: 4, name: "Yellow", code: "FFFF00"),
              CarColor.init(id: 5, name: "Green", code: "008000"),
              CarColor.init(id: 6, name: "Blue", code: "0000FF"),
    ]
    
    private static let carTypes = [CarType.init(id: 1, name: "Sedan", image: UIImage.init(named: "sedanicon")),
                                   CarType.init(id: 2, name: "Cabriolet", image: UIImage.init(named: "cabrioleticon")),
                                   CarType.init(id: 3, name: "Hatchback", image: UIImage.init(named: "hatchbackicon")),
                                   CarType.init(id: 4, name: "Coupe", image: UIImage.init(named: "coupeicon")),
                                   CarType.init(id: 5, name: "Sport car", image: UIImage.init(named: "sportcaricon")),
                                   CarType.init(id: 6, name: "SUV", image: UIImage.init(named: "suvicon"))]
    
    static func carForId(_ id: Int) -> CarType {
        return carTypes.filter { (car) -> Bool in
            return car.id == id
        }.first!
    }
    
    private static let carDecorationTypes = [CarDecorationType.init(id: 1, name: "Lite", image: UIImage.init(named: "carlauxe")),
                                      CarDecorationType.init(id: 2, name: "Lauxe", image: UIImage.init(named: "carlauxe")),
                                      CarDecorationType.init(id: 3, name: "Super lauxe", image: UIImage.init(named: "carlauxe"))]
    static func decorationType(id:Int) -> CarDecorationType {
        return carDecorationTypes.filter { (car) -> Bool in
            return car.id == id
        }.first!
    }
    
}

struct CarColor {
    let id: Int
    let name: String
    let code : String
}

struct CarType {
    let id: Int
    let name: String
    let image: UIImage?
}

struct CarDecorationType {
    let id: Int
    let name: String
    let image: UIImage?
}


//
//  UIColorExtension.swift
//  floriaConsumer
//
//  Created by arabpas on 12/25/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}


class A {
    var a:Int
    
    init(a:Int) {
        self.a=a
    }
}

class B: A {
    var b:Int
    
    convenience init() {
        self.init(b:2)
    }
    
    init(b:Int) {
        self.b=b
        super.init(a: 0)
    }
    
    init(a:Int,b:Int) {
        self.b = b
        super.init(a: a)
    }
}

let b = B.init(b: 3)

//
//  UIViewExtension.swift
//  floriaConsumer
//
//  Created by arabpas on 11/25/19.
//  Copyright © 2019 Obida. All rights reserved.
//


import UIKit

extension UIView {

    func addShadow(shadowColor: UIColor, offSet: CGSize, opacity: Float, shadowRadius: CGFloat, cornerRadius: CGFloat, corners: UIRectCorner, fillColor: UIColor = .white) {

        let shadowLayer = CAShapeLayer()
        let size = CGSize(width: cornerRadius, height: cornerRadius)
        let cgPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: size).cgPath //1
        shadowLayer.path = cgPath //2
        shadowLayer.fillColor = fillColor.cgColor //3
        shadowLayer.shadowColor = shadowColor.cgColor //4
        shadowLayer.shadowPath = cgPath
        shadowLayer.shadowOffset = offSet //5
        shadowLayer.shadowOpacity = opacity
        shadowLayer.shadowRadius = shadowRadius
        self.layer.addSublayer(shadowLayer)
    }
    
    
    func dropRoundedShadowForAllSides(_ radius: CGFloat) {
        let backgroundView = UIView(frame:self.frame)
        let radius = radius
        backgroundView.layer.masksToBounds = false
        self.layer.masksToBounds = true
        backgroundView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        backgroundView.layer.shadowRadius = 2
        backgroundView.layer.shadowOpacity = 0.2

        let path = UIBezierPath()

        // Start at the Top Left Corner + radius distance
        path.move(to: CGPoint(x: 2*radius, y: 0.0))

        // Move to the Top Right Corner - radius distance
        path.addLine(to: CGPoint(x: backgroundView.frame.size.width - radius, y: 0.0))

        // Move to top right corner + radius down as curve
        let centerPoint1 = CGPoint(x:backgroundView.frame.size.width - radius,y:radius)
        path.addArc(withCenter: centerPoint1, radius: radius, startAngle: 3*(.pi/2), endAngle: 0, clockwise: true)

        // Move to the Bottom Right Corner - radius
        path.addLine(to: CGPoint(x: backgroundView.frame.size.width, y: backgroundView.frame.size.height - radius))

        // Move to top right corner + radius left as curve
        let centerPoint2 = CGPoint(x:backgroundView.frame.size.width - radius,y:backgroundView.frame.size.height - radius)
        path.addArc(withCenter: centerPoint2, radius: radius, startAngle: 0, endAngle: .pi/2, clockwise: true)

        // Move to the Bottom Left Corner - radius
        path.addLine(to: CGPoint(x: radius, y: backgroundView.frame.size.height))

        // Move to left right corner - radius up as curve
        let centerPoint3 = CGPoint(x:radius,y:backgroundView.frame.size.height - radius)
        path.addArc(withCenter: centerPoint3, radius: radius, startAngle: .pi/2, endAngle: .pi, clockwise: true)

        // Move to the top Left Corner - radius
        path.addLine(to: CGPoint(x: 0, y: radius))

        // Move to top right corner + radius down as curve
        let centerPoint4 = CGPoint(x:radius,y:radius)
        path.addArc(withCenter: centerPoint4, radius: radius, startAngle: .pi, endAngle: 3 * (.pi/2), clockwise: true)

        path.close()

        backgroundView.layer.shadowPath = path.cgPath
        if let superView = self.superview {
            superView.addSubview(backgroundView)
            superView.sendSubviewToBack(backgroundView)
            superView.bringSubviewToFront(self)
        }

    }
}


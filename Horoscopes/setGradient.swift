//
//  setGradient.swift
//  Horoscopes
//
//  Created by Nguyen Duc Minh on 1/23/21.
//

import Foundation
import UIKit
extension UIView{
    public func setGradient(color1:UIColor, color2:UIColor){
        let gradient = CAGradientLayer()
        gradient.colors = [color1.cgColor, color2.cgColor]
        gradient.locations = [0.0 ,1.0]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.frame = bounds
      
        layer.insertSublayer(gradient, at: 0)
    }
}


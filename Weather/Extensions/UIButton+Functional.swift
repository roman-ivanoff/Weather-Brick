//
//  UIButton+Functional.swift
//  Weather
//
//  Created by Roman Ivanov on 08.09.2022.
//

import UIKit

extension UIButton {
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
        return gradient
    }
}

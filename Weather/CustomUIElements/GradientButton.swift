//
//  GradientButton.swift
//  Weather
//
//  Created by Roman Ivanov on 17.08.2022.
//

import UIKit

class GradientButton: UIButton {
    override class var layerClass: AnyClass {
        CAGradientLayer.self
    }

    var gradientLayer: CAGradientLayer {
        layer as! CAGradientLayer
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        gradientLayer.colors = [UIColor(hexString: "#FF9960").cgColor, UIColor(hexString: "#F9501B").cgColor]
        gradientLayer.locations = [0.1, 0.9]

        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 3
        layer.shadowOffset = CGSize(width: 4, height: 4)
    }
}


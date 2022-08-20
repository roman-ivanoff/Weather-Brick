//
//  ViewController.swift
//  Weather
//
//  Created by Roman Ivanov on 17.07.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var brickImage: UIImageView!
    @IBOutlet weak var infoButton: GradientButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var locationStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        infoButton.layer.cornerRadius = 15
    }


}


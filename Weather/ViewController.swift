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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        infoButton.layer.cornerRadius = 15
    }


}


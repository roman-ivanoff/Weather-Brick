//
//  ViewController.swift
//  Weather
//
//  Created by Roman Ivanov on 17.07.2022.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var brickImage: UIImageView!
    @IBOutlet weak var infoButton: GradientButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var locationStackView: UIStackView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var hideButton: UIButton!
    @IBOutlet weak var cBrickImageTop: NSLayoutConstraint!
    @IBOutlet weak var cBrickImageHeight: NSLayoutConstraint!
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        infoButton.layer.cornerRadius = 15
    }


}


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
    @IBOutlet weak var infoTextView: UITextView!
    var weather: OpenWeather?
    let weatherBrick = WeatherBrick()
    private var brickHeightConstant: CGFloat = 0
    private var isAnimationFinished = false
    private var heightForUpdate: CGFloat = 150

    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setInfoView()
        infoButton.layer.cornerRadius = 15

        weatherBrick.delegate = self

        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleBrickPan(_:)))
        brickImage.addGestureRecognizer(panGesture)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        weatherBrick.updateWeatherAtCurrentLocation()
    }

    @objc func handleBrickPan(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            brickHeightConstant = cBrickImageHeight.constant
            brickImage.transform = .identity
            if isAnimationFinished {
                brickImage.layer.removeAllAnimations()
                brickImage.layer.anchorPoint = .init(x: 0.5, y: 0.5)
                cBrickImageTop.constant = 0
            }
        case .changed:
            let translationY = sender.translation(in: view).y
            cBrickImageHeight.constant = brickHeightConstant + translationY
            if translationY > heightForUpdate {
                weatherBrick.updateWeatherAtCurrentLocation()
                sender.isEnabled = false
                sender.isEnabled = true
            }
        case .ended, .cancelled, .failed:
            cBrickImageHeight.constant = brickHeightConstant
            UIView.animate(withDuration: 1, delay: 0, options: []) { [self] in
                view.layoutIfNeeded()
            } completion: { [self] _ in
                if weatherBrick.isWindy {
                    animateBrick()
                }
            }
        default:
            break
        }
    }

    private func setInfoView() {
        infoView.layer.cornerRadius = 15

        infoView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        infoView.layer.shadowOpacity = 1
        infoView.layer.shadowRadius = 3
        infoView.layer.shadowOffset = CGSize(width: 4, height: 4)

        shadowView.layer.cornerRadius = 15

        setInfoTextView()

        setHideButton()
    }

    private func setInfoTextView() {
        let infoString = "Brick is wet - raining\nBrick is dry - sunny\n" +
        "Brick is hard to see - fog\nBrick with cracks - very hot\nBrick with snow - snow\n" +
        "Brick is swinging- windy\nBrick is gone - No Internet"
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 13
        let attributes = [NSAttributedString.Key.paragraphStyle: paragraphStyle]
        infoTextView.attributedText = NSAttributedString(string: infoString, attributes: attributes)
    }

    private func setHideButton() {
        hideButton.layer.cornerRadius = 15
        hideButton.layer.borderWidth = 1
        hideButton.layer.borderColor = UIColor(hexString: "#575757").cgColor
    }

    func updateBrickImage() {
        switch self.weatherBrick.brickState {
        case .rain:
            self.brickImage.image = UIImage(named: "image_stone_wet")
        case .sunny:
            self.brickImage.image = UIImage(named: "image_stone_normal")
        case .snow:
            self.brickImage.image = UIImage(named: "image_stone_snow")
        case .clouds:
            self.brickImage.image = UIImage(named: "image_stone_normal")
            self.brickImage.alpha = 0.7
        case .hot:
            self.brickImage.image = UIImage(named: "image_stone_cracks")
        case .unknown:
            self.brickImage.image = UIImage(named: "image_stone_normal")
        }

        if self.weatherBrick.isWindy {
            animateBrick()
        }

        if weatherBrick.brickState != .clouds {
            self.brickImage.alpha = self.weatherBrick.isFoggy ? 0.6 : 1
        }

        self.brickImage.isHidden = false
    }

    private func animateBrick() {
        cBrickImageTop.constant = -cBrickImageHeight.constant / 2
        brickImage.layer.anchorPoint = CGPoint(x: 0.5, y: 0.0)
        brickImage.accessibilityValue = "animation"

        UIView.animate(withDuration: 1, delay: 0, options: .beginFromCurrentState) { [brickImage] in
            brickImage?.transform = CGAffineTransform(rotationAngle: 0.2)
        } completion: { [self] _ in
            UIView.animate(
                withDuration: 2,
                delay: 0,
                options: [.beginFromCurrentState, .repeat, .autoreverse, .allowUserInteraction]
            ) { [self] in
                self.isAnimationFinished = false
                self.brickImage?.transform = CGAffineTransform(rotationAngle: -0.2)
            } completion: { [self] _ in
                self.isAnimationFinished = true
            }
        }
    }

    private func clearAll() {
        DispatchQueue.main.async {
            self.tempLabel.text = ""
            self.weatherLabel.text = ""
            self.locationLabel.text = ""
            self.brickImage.isHidden = true
        }
    }

    @IBAction func hideInfoAction(_ sender: UIButton) {
        UIView.transition(
            with: self.view,
            duration: 0.4,
            options: .transitionCrossDissolve
        ) { [self] in
            brickImage.isHidden = false
            tempLabel.isHidden = false
            weatherLabel.isHidden = false
            locationLabel.isHidden = false
            infoButton.isHidden = false
            searchButton.isHidden = false
            locationButton.isHidden = false

            infoView.isHidden = true
            shadowView.isHidden = true
        }
    }
    
    @IBAction func showInfoAction(_ sender: UIButton) {
        UIView.transition(
            with: self.view,
            duration: 0.4,
            options: .transitionCrossDissolve
        ) { [self] in
            brickImage.isHidden = true
            tempLabel.isHidden = true
            weatherLabel.isHidden = true
            locationLabel.isHidden = true
            infoButton.isHidden = true
            searchButton.isHidden = true
            locationButton.isHidden = true

            infoView.isHidden = false
            shadowView.isHidden = false
        }
    }
}

extension ViewController: WeatherBrickDelegate {
    func weatherBrick(_ weatherModel: WeatherBrickProtocol, willUpdate weather: OpenWeather?) {
        clearAll()
    }

    func weatherBrick(_ weatherModel: WeatherBrickProtocol, didUpdate weather: OpenWeather?) {
        guard let weather = weather else {
            clearAll()
            return
        }

        DispatchQueue.main.async {
            self.errorLabel.isHidden = true
            self.tempLabel.text = DegreeSymbolFormatter.addDegreeSymbol(weather.main.temp)
            self.tempLabel.isHidden = false
            self.weatherLabel.text = weather.weather[0].main.lowercased()
            self.weatherLabel.isHidden = false
            self.locationLabel.text = "\(weather.name), \(weather.sys.country)"
            self.locationStackView.isHidden = false
            self.updateBrickImage()
        }
    }

    func weatherBrick(_ weatherModel: WeatherBrickProtocol, errorOccured error: Error) {
        clearAll()
        func showError() {
            errorLabel.text = error.localizedDescription
            errorLabel.isHidden = false
        }
        if Thread.current.isMainThread {
            showError()
        } else {
            showError()
        }
    }
}

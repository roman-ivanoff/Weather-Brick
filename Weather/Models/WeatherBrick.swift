//
//  WeatherBrick.swift
//  Weather
//
//  Created by Roman Ivanov on 09.09.2022.
//

import Foundation
import CoreLocation

enum WeatherBrickState {
    case rain
    case sunny
    case snow
    case clouds
    case hot
    case unknown
}

class WeatherBrick {
    var delegate: WeatherBrickDelegate?
    let hotTempInKelvin = 302.15 // 29 celcius
    let fogVisibility = 1000
    let windSpeed = 10.0

    var isWindy = false
    var isFoggy = false
    var isHot = false

    let queue = DispatchQueue(label: "ViewController operation execution queue")
    var brickState: WeatherBrickState = .sunny

    let locationService = LocationService()
    var currentLocation: CLLocation?
    let queryService = QueryService()
    private(set) var weather: OpenWeather? {
        didSet {
            delegate?.weatherBrick(self, didUpdate: weather)
            setStates()
        }
    }
    var error: String?

    init() {
        locationService.registerObserver(observer: self)

        locationService.requestLocation()
    }

    func updateLocation(location: CLLocation) {
        self.currentLocation = location
        updateWeatherAtCurrentLocation()
    }

    func updateWeatherAtCurrentLocation() {
        delegate?.weatherBrick(self, didUpdate: weather)
        DispatchQueue.main.async {
            self.getWeather()
        }
    }

    func updateError(error: Error) {
        delegate?.weatherBrick(self, errorOccured: error)
    }
}

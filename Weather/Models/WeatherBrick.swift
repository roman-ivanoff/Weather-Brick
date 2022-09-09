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

class WeatherBrick: LocationObserver, WeatherBrickProtocol {
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

    private func setStates() {
        isHot = weather?.main.temp ?? 0 > hotTempInKelvin
        isFoggy = weather?.visibility ?? 0 > fogVisibility
        isWindy = weather?.wind.speed ?? 0 > windSpeed

        switch weather?.weather[0].main {
        case "Clouds":
            brickState = .clouds
        case "Clear":
            brickState = isHot ? .hot : .sunny
        case "Rain":
            brickState = .rain
        case "Snow":
            brickState = .snow
        default:
            brickState = .unknown
        }
    }

    func getWeather() {
        guard let location = locationService.location else {
            locationService.requestLocation()
            return
        }
        let lat = String(location.coordinate.latitude)
        let lon = String(location.coordinate.longitude)

        self.queryService.getWeather(lat: lat, lon: lon) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .failure(let error):
                self.delegate?.weatherBrick(self, errorOccured: error)
            case .success(let weather):
                self.weather = weather
            }
        }
    }
}

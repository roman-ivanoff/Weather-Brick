//
//  LocationService.swift
//  Weather
//
//  Created by Roman Ivanov on 07.09.2022.
//

import Foundation
import CoreLocation

class LocationService: NSObject, CLLocationManagerDelegate {
    var observers: [LocationObserver] = []
    let manager = CLLocationManager()

    var location: CLLocation?

    override init() {
        super.init()

        manager.delegate = self
    }

    func registerObserver(observer: LocationObserver) {
        observers.append(observer)
    }

    func notifyObserverAboutLocation(location: CLLocation) {
        for observer in observers {
            observer.updateLocation(location: location)
        }
    }

    func notifyObserverAboutError(error: Error) {
        for observer in observers {
            observer.updateError(error: error)
        }
    }

    func requestLocation() {
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined:
                manager.requestWhenInUseAuthorization()
            case .restricted, .denied:
                notifyObserverAboutError(error: LocationError.invalidAuthorization)
            case .authorizedAlways, .authorizedWhenInUse:
                manager.requestLocation()
            }
        } else {
            notifyObserverAboutError(error: LocationError.invalidLocationService)
        }

//        manager.requestWhenInUseAuthorization()
//        manager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let status = CLLocationManager.authorizationStatus()
        if  status == .authorizedWhenInUse ||
            status == .authorizedAlways {
            if let location = locations.first {
                self.location = location
                notifyObserverAboutLocation(location: location)
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            notifyObserverAboutError(error: LocationError.invalidAuthorization)
        case .authorizedAlways, .authorizedWhenInUse:
            manager.requestLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        notifyObserverAboutError(error: error)
    }
}

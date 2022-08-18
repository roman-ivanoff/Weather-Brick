//
//  LocationObserver.swift
//  Weather
//
//  Created by Roman Ivanov on 18.08.2022.
//

import Foundation
import CoreLocation

protocol LocationObserver {
    func updateLocation(location: CLLocation)
    func updateError(error: Error)
}

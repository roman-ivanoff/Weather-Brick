//
//  WeatherBrickProtocol.swift
//  Weather
//
//  Created by Roman Ivanov on 18.08.2022.
//

import Foundation

protocol WeatherBrickProtocol {
    var delegate: WeatherBrickDelegate? { get set }

    func updateWeatherAtCurrentLocation()
}

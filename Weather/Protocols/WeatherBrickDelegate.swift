//
//  WeatherBrickDelegate.swift
//  Weather
//
//  Created by Roman Ivanov on 18.08.2022.
//

import Foundation

protocol WeatherBrickDelegate: AnyObject {
    func weatherBrick(_ weatherModel: WeatherBrickProtocol, willUpdate weather: OpenWeather?)
    func weatherBrick(_ weatherModel: WeatherBrickProtocol, didUpdate weather: OpenWeather?)
    func weatherBrick(_ weatherModel: WeatherBrickProtocol, errorOccured error: Error)
}

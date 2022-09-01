//
//  OpenWeather.swift
//  Weather
//
//  Created by Roman Ivanov on 28.07.2022.
//

import Foundation

struct OpenWeather: Codable, Equatable {
    let coord: Coordinates
    let weather: [Weather]
    let main: WeatherInfo
    let visibility: Int
    let wind: Wind
    let sys: WeatherCountry
    let name: String
    let cod: Int
}

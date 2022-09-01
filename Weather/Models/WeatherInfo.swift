//
//  WeatherInfo.swift
//  Weather
//
//  Created by Roman Ivanov on 28.07.2022.
//

import Foundation

struct WeatherInfo: Codable, Equatable {
    let temp: Double
    let humidity: Int
}

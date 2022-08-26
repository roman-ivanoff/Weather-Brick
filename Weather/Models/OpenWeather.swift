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

    static func == (lhs: OpenWeather, rhs: OpenWeather) -> Bool {
        var isWeatherEqual = true
        for lWeather in lhs.weather {
            for rWeather in rhs.weather {
                if lWeather.id != rWeather.id {
                    isWeatherEqual = false
                    break
                }

                if lWeather.main != rWeather.main {
                    isWeatherEqual = false
                    break
                }

                if lWeather.description != rWeather.description {
                    isWeatherEqual = false
                    break
                }
            }
        }

        return lhs.coord.lat == rhs.coord.lat &&
        lhs.coord.lon == rhs.coord.lon &&
        isWeatherEqual &&
        lhs.main.humidity == rhs.main.humidity &&
        lhs.main.temp == rhs.main.temp &&
        lhs.visibility == rhs.visibility &&
        lhs.wind.deg == rhs.wind.deg &&
        lhs.wind.speed == rhs.wind.speed &&
        lhs.sys.country == lhs.sys.country &&
        lhs.name == rhs.name &&
        lhs.cod == rhs.cod
    }
}

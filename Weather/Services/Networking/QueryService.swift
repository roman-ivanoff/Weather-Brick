//
//  QueryService.swift
//  Weather
//
//  Created by Roman Ivanov on 29.07.2022.
//

import Foundation

enum WeatherError: Error {
    case noDataAvailable
    case cannotProcessData
}

class QueryService {
    var session: URLSession
    let link = "https://api.openweathermap.org/data/2.5/weather"
    let apiKey = "306323172c79e995cf092b53477fe2dc"
    var dataTask: URLSessionDataTask?

    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }

    func getWeather(lat: String, lon: String, completion: @escaping(Result<OpenWeather, WeatherError>) -> Void) {
        #if DEBUG
        if ProcessInfo.processInfo.arguments.contains("mock") {
            let sampleOpenWeatherData = OpenWeather(
                coord: Coordinates(lon: -122.08, lat: 37.39),
                weather: [Weather(id: 1, main: "Clear", description: "clear sky")],
                main: WeatherInfo(temp: 282.55, humidity: 100),
                visibility: 10000,
                wind: Wind(speed: 1.5, deg: 300),
                sys: WeatherCountry(country: "US"),
                name: "Mountain View",
                cod: 200
            )

            DispatchQueue.main.async {
                completion(.success(sampleOpenWeatherData))
            }

            return
        }

        if ProcessInfo.processInfo.arguments.contains("animation") {
            let sampleOpenWeatherData = OpenWeather(
                coord: Coordinates(lon: -122.08, lat: 37.39),
                weather: [Weather(id: 1, main: "Clear", description: "clear sky")],
                main: WeatherInfo(temp: 282.55, humidity: 100),
                visibility: 10000,
                wind: Wind(speed: 11.5, deg: 300),
                sys: WeatherCountry(country: "US"),
                name: "Mountain View",
                cod: 200
            )

            DispatchQueue.main.async {
                completion(.success(sampleOpenWeatherData))
            }

            return
        }
        #endif

        dataTask?.cancel()
        if var urlComponents = URLComponents(string: link) {
            urlComponents.queryItems = [
                URLQueryItem(name: "lat", value: lat),
                URLQueryItem(name: "lon", value: lon),
                URLQueryItem(name: "appid", value: apiKey)
            ]

            guard let url = urlComponents.url else {
                return
            }

            dataTask = session.dataTask(with: url) { data, _, _ in
                guard let jsonData = data else {
                    DispatchQueue.main.async {
                        completion(.failure(.noDataAvailable))
                    }
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let postResponse = try decoder.decode(OpenWeather.self, from: jsonData)
                    DispatchQueue.main.async {
                        completion(.success(postResponse))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(.cannotProcessData))
                    }
                }
            }

            dataTask?.resume()
        }
    }
}

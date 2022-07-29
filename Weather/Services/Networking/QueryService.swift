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
    let session = URLSession(configuration: .default)
    let link = "https://api.openweathermap.org/data/2.5/weather"
    let apiKey = "151c855c063f34c1d6734cea30dc5d5d"
    var dataTask: URLSessionDataTask?

    func getWeather(lat: String, lon: String, completion: @escaping(Result<OpenWeather, WeatherError>) -> Void) {
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

//
//  QueryServiceTests.swift
//  WeatherTests
//
//  Created by Roman Ivanov on 14.09.2022.
//

import XCTest
@testable import Weather

class QueryServiceTests: XCTestCase {

    var urlSession: URLSession!

    override func setUpWithError() throws {
        try super.setUpWithError()
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        urlSession = URLSession(configuration: configuration)
    }

    func testGetWeather() throws {
        let queryService = QueryService(session: urlSession)

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

        let mockData = try JSONEncoder().encode(sampleOpenWeatherData)

        MockURLProtocol.requestHandler = { _ in
            return (HTTPURLResponse(), mockData)
        }

        let expectation = XCTestExpectation(description: "response")

        queryService.getWeather(lat: String(-122.08), lon: String(37.39)) { result in
            switch result {
            case .success(let weather):
                XCTAssertEqual(sampleOpenWeatherData, weather)

                expectation.fulfill()
            case .failure(let error):
                XCTAssertEqual(error, WeatherError.noDataAvailable)
            }

            self.wait(for: [expectation], timeout: 1)
        }
    }

}
